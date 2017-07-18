def f(input)
  log = HilightLog.new(input)
  log.run
  log.hilight_count.to_s
end

class HilightLog
  attr_accessor :l, :n, :logs, :text, :hilight_count

  def initialize(input)
    lines = input.split("\n")
    @l, @n = lines[0].split(' ').map(&:to_i)
    @logs = lines[1..@n].map { |l| l.split(' ').map(&:to_i) }
    @text = '0' * @l
    @hilight_count = 0
  end

  def run
    @logs.each do |s, e|
      hilight(s, e)
    end
  end

  def unhilight(s, e)
    r = (s - 1)..(e - 1)
    l = r.size
    if @text[r] == '1' * l
      @text[r] = '0' * l
      true
    else
      false
    end
  end

  def hilight(s, e)
    return if unhilight(s, e)
    r = (s - 1)..(e - 1)
    l = r.size
    @text[r] = '1' * l
  end

  def hilight_count
    @text.delete('0').size
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
