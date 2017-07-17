def f(input)
  highlight = Highlight.new(input)
  highlight.run
  highlight.active_count.to_s
end

class Highlight
  attr_reader :l, :n, :logs, :actives, :active_count

  def initialize(input)
    lines = input.split("\n")
    @l, @n = lines[0].split(' ').map(&:to_i)
    @logs = lines[1..@n].map { |l| l.split(' ').map(&:to_i) }
    @actives = Array.new(10**9 + 1)
    @gs = 0 # ハイライト全体の最初
    @ge = 0 # ハイライト全体の最後
    @active_count = 0
  end

  def run
    @logs.each do |s, e|
      highlight(s, e)
    end
  end

  def try_unhilight(s, e)
    ret = false
    if (s..e).all? { |i| @actives[i] }
      (s..e).each do |i|
        @actives[i] = nil
        @active_count -= 1
      end
      ret = true
    end
    ret
  end

#  def try_partial_hilight(s, e)
#    ret = false
#    @actives.each.with_index(0) do |(as, ae), i|
#      if s <= as && e <= ae
#        @actives[i] = [s, ae]
#        ret = true
#        break
#      elsif as <= s && ae <= e
#        @actives[i] = [as, e]
#        ret = true
#        break
#      end
#    end
#    ret
#  end

  def just_highlit(s, e)
    (s..e).each do |i|
      unless @actives[i]
        @actives[i] = true
        @active_count += 1
      end
    end
  end

  def highlight(s, e)
#    update_global_start(s)
#    update_global_end(e)
    try_unhilight(s, e) || just_highlit(s, e)
  end

#  def update_global_start(s)
#    @gs = s if s < @gs
#  end
#
#  def update_global_end(e)
#    @ge = e if @ge < e
#  end

#  def before_global_start?(e)
#    e < @gs
#  end
#
#  def after_global_end?(s)
#    @ge < s
#  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
