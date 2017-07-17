def f(input)
  highlight = Highlight.new(input)
  highlight.run
  highlight.active_count.to_s
end

class Highlight
  attr_reader :l, :n, :logs, :actives

  def initialize(input)
    lines = input.split("\n")
    @l, @n = lines[0].split(' ').map(&:to_i)
    @logs = lines[1..@n].map { |l| l.split(' ').map(&:to_i) }
    @actives = []
    @gs = 0 # ハイライト全体の最初
    @ge = 0 # ハイライト全体の最後
  end

  def run
    @logs.each do |s, e|
      highlight(s, e)
    end
  end

  def try_unhilight(s, e)
    ret = false
    @actives.each.with_index(0) do |(as, ae), i|
      if (as..ae).cover?(s) && (as..ae).cover?(e)
        @actives[i] = [as, s - 1]
        @actives.insert(i + 1, [e, ae])
        ret = true
        break
      end
    end
    ret
  end

  def try_partial_hilight(s, e)
    remove_candidates = []
#    require 'byebug'
#    byebug
    # 完全カバーされてるのでいらなくなるもの
    @actives.each.with_index(0) do |(as, ae), i|
      if (s..e).cover?(as) && (s..e).cover?(ae)
        remove_candidates << [as, ae]
      else
        # 左が重なる
        if as <= s && ae <= e
          @actives[i] = [as, e]
        elsif as <= e
          # 右が重なる
          @actives[i] = [s, ae]
        end
      end
    end
    remove_candidates.each do |c|
      @actives.delete(c)
    end

    # 範囲の左側なので単に追加出来るもの
    if before_global_start?(s)
      just_highlit(s, e)
    end

    # 範囲の右側なので単に追加出来る
    if after_global_end?(e)
      just_highlit(s, e)
    end
  end

  def just_highlit(s, e)
    @actives << [s, e]
  end

  def highlight(s, e)
    update_global_start(s)
    update_global_end(e)
    try_unhilight(s, e) || try_partial_hilight(s, e)
  end

  def update_global_start(s)
    @gs = s if s < @gs
  end

  def update_global_end(e)
    @ge = e if @ge < e
  end

  def before_global_start?(e)
    e < @gs
  end

  def after_global_end?(s)
    @ge < s
  end

  def active_count
    @actives.each.inject(0) do |sum, (s, e)|
      sum + (e - s)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
