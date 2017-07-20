class Liar
  attr_accessor :n, :m, :saids, :be_saids

  def initialize(n, m)
    @n = n.to_i
    @m = m.to_i
    # 言及状況を保存
    @saids = Hash.new { |h, k| h[k] = {} }
    # 言及されている状況
    @be_saids = {}
    @process_count = 0
  end

  class << self
    def run(input)
      lines = input.split("\n")
      n, m = lines[0].split(' ').map(&:to_i)
      liar = Liar.new(n, m)
      m.times do |i|
        memo_text = lines[i + 1]
        unless liar.run(memo_text)
          break
        end
      end
      liar.output.to_s
    end
  end

  def run(memo_text)
    if (memo = load_memo(memo_text))
      if valid?(memo)
        store(memo)
        return true
      else
        @ret = -1
        return false
      end
    end
  end

  def valid?(memo)
    # 自分を嘘付きだと言えない
    if memo[0] == memo[1] && memo[2] == :l
      return false
    end

    # 既に言及した内容と逆のことを言及することは矛盾する
    if (say = @saids.dig(memo[0], memo[1])) && say != memo[2]
      return false
    end

    true
  end

  def store(memo)
    @saids[memo[0]][memo[1]] = memo[2]
    @be_saids[memo[1]] = memo[0]
    @process_count += 1
  end

  def output
    # 処理成功ごとに場合の数が2ずつ減る
    # 欲しいものは想定出来る組み合わせ総数の2進数表現の桁数
    @ret || (2**(@n - @process_count)).to_s(2).size
  end

  def load_memo(memo_text)
    ret =
      if /(?<speaker>\d) said (?<target>\d) was an honest person/ =~ memo_text
        [speaker.to_i, target.to_i, :h]
      elsif /(?<speaker>\d) said (?<target>\d) was a liar/ =~ memo_text
        [speaker.to_i, target.to_i, :l]
      end
    ret
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts Liar.run(input)
end
