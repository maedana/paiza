def f(input)
  Sugoroku.new(input).run
end

class Sugoroku
  attr_reader :t, :b, :u, :d, :l, :r, :n, :p
  def initialize(input)
    lines = input.split("\n")
    # t(op) 上
    # b(ottom) 下
    # u(p) 前
    # d(own) 後
    # l(eft) 手前
    # r(ight) 奥
    @t, @b, @u, @d, @l, @r = lines[0].split(' ').map(&:to_i)
    @n = lines[1].to_i
    @p = lines[2..@n + 1].map(&:to_i)
    @count = 0
    @current_pos = 0
  end

  def run
    until @t == @p.last && @current_pos == @p.size - 1
      dump
      case next_num
      when @t
        go_next
      when @b
        round_r
        round_r
        go_next
      when @u
        round_d
        go_next
      when @d
        round_u
        go_next
      when @l
        round_r
        go_next
      when @r
        round_l
        go_next
      end
      dump
    end
    @count.to_s
  end

  def dump
    # puts "上: #{@t}, 手前: #{@l}, 前: #{@u}, 次値: #{next_num}, 位置: #{@current_pos}, 回転数: #{@count}"
  end

  # 進行方向回転
  def round_u
    @t, @b, @u, @d, @l, @r = *[@d, @u, @t, @b, @l, @r]
    @count += 1
  end

  # 奥回転
  def round_r
    @t, @b, @u, @d, @l, @r = *[@l, @r, @u, @d, @b, @t]
    @count += 1
  end

  # 手前回転
  def round_l
    @t, @b, @u, @d, @l, @r = *[@r, @l, @u, @d, @t, @b]
    @count += 1
  end

  # 後ろ回転
  def round_d
    @t, @b, @u, @d, @l, @r = *[@u, @d, @b, @t, @l, @r]
    @count += 1
  end

  def next_num
    @p[@current_pos + 1]
  end

  def go_next
    @current_pos += 1
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
