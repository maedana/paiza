def f(l, n, m, line_text)
  # 縦棒ごとに高さ順でソートした配列を持つhashを用意
  amida_tree = AmidaTree.new(l, n, m, line_text)
  loop do
    break if amida_tree.next.nil?
  end
  amida_tree.current_pos_h
end

class AmidaTree
  attr_reader :sorted_tree, :current_pos_h

  def initialize(l, n, m, line_text)
    @l = l.to_i # 線の長さ
    @n = n.to_i # 縦線数
    @m = m.to_i # 横線数
    @line_text = line_text
    # 縦線ごとにソートされた横線の配列を持つHash
    set_sorted_tree
    @current_pos_h = 1
    @current_pos_v = @l
  end

  def [](n_index)
    @sorted_tree[n_index]
  end

  def next
    left = find_left
    right = find_right
    if left
      if right
        if left[2] > right[1]
          @next = left
          solve_left
        else
          @next = right
          solve_right
        end
      else
        @next = left
        solve_left
      end
    else
      if right
        @next = right
        solve_right
      end
    end
  end

  def find_left
    if (lines = @sorted_tree[@current_pos_h - 1]) && !lines.size.zero?
      lines.find { |d| d[2] < @current_pos_v }
    end
  end

  def find_right
    if (lines = @sorted_tree[@current_pos_h]) && !lines.size.zero?
      lines.find { |d| d[1] < @current_pos_v }
    end
  end

  def solve_left
    @sorted_tree[@current_pos_h - 1].delete(@next)
    @current_pos_v = @next[1]
    @current_pos_h -= 1
  end

  def solve_right
    @sorted_tree[@current_pos_h].delete(@next)
    @current_pos_h += 1
    @current_pos_v = @next[2]
  end

  private

  def set_sorted_tree
    @sorted_tree = Hash.new {|h, k| h[k] = [] }
    @line_text.split("\n").each do |line|
      definition = line.split(' ').map(&:to_i)
      @sorted_tree[definition[0]] << definition
    end
    (1...@n).each do |n|
      @sorted_tree[n].sort_by! { |_a, b, _c| -b }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  l, n, m = STDIN.gets.split(' ')
  line_text = STDIN.readlines.join('')
  puts f(l, n, m, line_text)
end
