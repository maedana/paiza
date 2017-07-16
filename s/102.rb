def f(n, s, m, p_text)
  progression = Progression.new(n, s, m, p_text)
  progression.resolve
  progression.answer
end

class Progression
  attr_reader :p, :answer

  def initialize(n, s, m, p_text)
    @n = n.to_i
    @s = s.split(' ').map(&:to_i)
    @m = m.to_i
    prepare_p(p_text)
  end

  def resolve
    replaced_arrays =
      replace_patterns.map do |pattern|
        apply(pattern)
      end
    @answer = replaced_arrays.sort.first.join(' ')
  end

  def apply(p_array)
    source = Marshal.load(Marshal.dump(@s))
    ret = Marshal.load(Marshal.dump(@s))
    p_array.each do |p_n|
      p_n.each.with_index(0) do |p_v, i|
        ret[p_v - 1] = source[i]
      end
      source = Marshal.load(Marshal.dump(ret))
    end
    ret
  end

  def replace_patterns
    (0..@p.size).inject([]) do |ret, count|
      ret + @p.permutation(count).to_a
    end
  end

  private

  def prepare_p(p_text)
    @p = p_text.split("\n").map { |line| line.split(' ').map(&:to_i) }
  end
end

if $PROGRAM_NAME == __FILE__
  n = STDIN.gets
  s = STDIN.gets
  m = STDIN.gets
  p_text = STDIN.readlines.join('')
  puts f(n, s, m, p_text)
end
