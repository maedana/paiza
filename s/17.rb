class Liar
  attr_accessor :n, :m, :memos

  def initialize(n, m)
    @n = n.to_i
    @m = m.to_i
    @memos = []
  end

  def run(memo_text)
    if (memo = load_memo(memo_text))
      if valid?(memo)
        store(memo)
      else
        return false
      end
    end
    true
  end

  def valid?(memo)
    # 自分を嘘付きだと言えない
    if memo[0] == memo[1] && !memo[2]
      return false
    end

    # bsearchとかにするべきかも
    if @memos.find {|m| m[0] == memo[0] && m[1] == memo[1] && m[2] != memo[2]}
      return false
    end

    return true
  end

  def store(memo)
    @memos << memo
  end

  def self.exec(input)
    lines = input.split("\n")
    n, m = lines[0].split(' ').map(&:to_i)
    liar = Liar.new(n, m)
    m.times do |i|
      memo_text = lines[i + 1]
      unless liar.run(memo_text)
        return '-1'
      end
    end
    liar.output
  end

  def output
    uniq_memo_count = @memos.uniq.size # 言及数
    # 2 の (村人数 - 言及数)乗
    answer_count = 2**(@n - uniq_memo_count)
    # 欲しいものは二進数表現したときの桁数
    answer_count.to_s(2).size.to_s
  end

  def load_memo(memo_text)
    ret =
      if /(?<speaker>\d) said (?<target>\d) was an honest person/ =~ memo_text
        [speaker.to_i, target.to_i, true]
      elsif /(?<speaker>\d) said (?<target>\d) was a liar/ =~ memo_text
        [speaker.to_i, target.to_i, false]
      end
    ret
  end
end

if $PROGRAM_NAME == __FILE__
  n, m = STDIN.gets.split(' ').map(&:to_i)
  liar = Liar.new(n, m)
  ret = nil
  m.times do
    memo_text = STDIN.gets
    unless liar.run(memo_text)
      ret = '-1'
    end
  end
  ret = liar.output if ret.nil?
  puts ret
end
