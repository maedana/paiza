def f(k, s, t)
  abc_str = AbcStr.new(k, s, t)
  abc_str.answer
end

class AbcStr
  attr_reader :text

  def initialize(k, s, t)
    @k = k.to_i
    @s = s.to_i
    @t = t.to_i
    @current_level = 1
    @text = 'ABC'
    prepare_text
  end

  def prepare_text
    (1...@k).each do |level|
      @current_level += 1
      @text = "A#{@text}B#{@text}C"
    end
  end

  def answer
    @text[(@s - 1)...@t]
  end
end

if $PROGRAM_NAME == __FILE__
  k, s, t = STDIN.gets.split(' ')
  puts f(k, s, t)
end
