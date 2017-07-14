def f(l, n, m, line_text)
  remaining_lines = lines(line_text)
  current_position_h = 1
  current_position_v = l.to_i
  while (bottom = find_bottom(current_position_v, current_position_h, remaining_lines, n))
    a, _b, c = bottom
    current_position_h =
      if current_position_h == a
        a + 1
      else
        a
      end
    current_position_v = c
    remaining_lines.delete(bottom)
  end
  current_position_h
end

def abc(line_text)
  lines(line_text).transpose
end

def find_bottom(current_position_v, current_position_h, remaining_lines, n)
  target_lines = remaining_lines.select { |a, b, _c| (a == current_position_h || a == current_position_h - 1) && b <= current_position_v }
  target_lines.sort_by { |_a, b, _c| b }.last
end

def lines(line_text)
  line_text.split("\n").map do |line|
    line.split(' ').map(&:to_i)
  end
end

if $PROGRAM_NAME == __FILE__
  l, n, m = STDIN.gets.split(' ')
  line_text = STDIN.readlines.join('')
  puts f(l, n, m, line_text)
end
