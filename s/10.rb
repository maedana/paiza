def f(input)
  mini_distance = MinDistance.new(input)
  mini_distance.run
  if mini_distance.complete_routes.size.positive?
    mini_distance.complete_routes.sort_by {|cr| cr.size }.first.size.to_s
  else
    'Fail'
  end
end

class MinDistance
  attr_reader :m, :n, :rows, :complete_routes, :s, :g

  def initialize(input)
    lines = input.split("\n")
    @m, @n = lines[0].split(' ').map(&:to_i)
    @rows =
      lines[1..@n].map.with_index(0) do |l, i|
        row = l.split(' ')
        if (sj = row.index('s'))
          @s = [i, sj]
        end
        if (gj = row.index('g'))
          @g = [i, gj]
        end
        row
      end
    @complete_routes = []
  end

  def run
    next_candidates(@s, []).each do |pos|
      move(pos, [])
    end
  end

  def move(pos, visited)
    visited << pos
    if pos == @g
      @complete_routes << Marshal.load(Marshal.dump(visited))
    else
      if (next_candidates = next_candidates(pos, visited)) && next_candidates.size.positive?
        next_candidates.each do |next_pos|
          move(next_pos, visited)
        end
      else
        visited.delete(pos)
      end
    end
  end

  def next_candidates(current_pos, visited)
    [
      up(current_pos, visited),
      down(current_pos, visited),
      right(current_pos, visited),
      left(current_pos, visited)
    ].compact
  end

  def up(current_pos, visited)
    x = current_pos.first
    y = current_pos.last - 1
    active_pos(x, y, visited)
  end

  def down(current_pos, visited)
    x = current_pos.first
    y = current_pos.last + 1
    active_pos(x, y, visited)
  end

  def right(current_pos, visited)
    x = current_pos.first + 1
    y = current_pos.last
    active_pos(x, y, visited)
  end

  def left(current_pos, visited)
    x = current_pos.first - 1
    y = current_pos.last
    active_pos(x, y, visited)
  end

  def active_pos(x, y, visited)
    n = [x, y]
    return nil if y.negative?
    return nil if x.negative?
    return nil if visited.include?(n)
    return nil if @rows[x]&.[](y) == '1'
    return nil if @rows[x]&.[](y) == 's'
    return nil if @rows[x]&.[](y).nil?
    n
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
