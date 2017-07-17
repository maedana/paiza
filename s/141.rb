def f(input)
  highlight = Highlight.new(input)
  highlight.run
  highlight.active_count.to_s
end

class Highlight
  attr_accessor :l, :n, :logs, :actives

  def initialize(input)
    lines = input.split("\n")
    @l, @n = lines[0].split(' ').map(&:to_i)
    @logs = lines[1..@n].map { |l| l.split(' ').map(&:to_i) }
    @actives = []
    @gs = nil # ハイライト全体の最初
    @ge = nil # ハイライト全体の最後
  end

  def run
    @logs.each do |s, e|
      require 'pp'
#      pp "入力: #{[s, e]}"
      highlight(s, e)
#      pp "結果: #{@actives}"
#      puts "===========================\n"
    end
  end

  def unhilight(s, e)
    ret = false
    @actives.each.with_index(0) do |(as, ae), i|
      if (as..ae).cover?(s) && (as..ae).cover?(e)
        @actives[i] = [as, s - 1]
        if e < ae
          @actives.insert(i + 1, [e + 1, ae])
        end
        ret = true
        break
      end
    end
    ret
  end

  def highlight(s, e)
    return if unhilight(s, e)
    ns = s
    ne = e

    if @actives.empty?
      @actives.push([ns, ne])
      return
    end

    @actives.each.with_index(0) do |(as, ae), i|
      # 範囲の左側なので単に追加出来る
      if ne + 1 < as
        @actives.unshift([s, e])
        break
      end

      # 最初に繋がる
      if as <= ne + 1 && s < as
        @actives[i] =
          if ae <= ne
            while @actives[i + 1] && @actives[i + 1].last <= ne
              @actives.delete_at(i + 1)
            end
            [ns, ne]
          else
            [ns, ae]
          end
        break
      end

      # 最後に繋がる
      if ns <= ae + 1
        @actives[i] = [as, ne]
        while @actives[i + 1] && @actives[i + 1].first <= ne + 1
          next_ae = @actives[i + 1].last
          #@actives[i] = [as, @actives.delete_at(i + 1).last]
          @actives[i] = [as, ne < next_ae ? next_ae : ne]
          @actives.delete_at(i + 1)
        end
        break
      end

      # 間に挟まる/後ろに入る
#      require 'byebug'
#      byebug
      if ae < ns
        if (next_item = @actives[i + 1])
          if ne < next_item.first
            @actives.insert(i + 1, [ns, ne])
            break
          else
#            @actives[i] = [ns, next_item.last]
#            @actives.delete_at(i + 1)
          end
        else
          @actives.push([s, e])
          break
        end
      end

#      if ae < ns
#        @actives.push([s, e])
##        break
#      end
    end
  end

  def active_count
    @actives.each.inject(0) do |sum, (s, e)|
      sum + (e - s + 1)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
