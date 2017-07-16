def f(k, s, t)
  abc_str = AbcStr.new(k, s, t)
  abc_str.answer
end

class AbcStr
  attr_reader :length

  def initialize(k, s, t)
    @k = k.to_i
    @s = s.to_i
    @t = t.to_i
    @current_pos = @s
    @answer = ''
    prepare_text_length_by_level
  end

  def answer
    resolve until @current_pos > @t
    @answer
  end

  def resolve
    level = @k
    level_pos = @current_pos
    loop do
      if resolve_left(level_pos, level) || resolve_center(level_pos, level) || resolve_right(level_pos, level)
        @current_pos += 1
        break
      else
        if center_pos(level) < level_pos
          # 中央より後ろの位置の場合、#{[k-1]の長さ}B分だけ余分にずらす必要がある
          level_pos -= @length[level - 1]
          level_pos -= 1
        end
        level_pos -= 1
        level -= 1
      end
    end
  end

  def resolve_left(level_pos, level)
    return false unless level_pos == left_pos
    @answer << 'A'
    true
  end

  def resolve_center(level_pos, level)
    return false unless level_pos == center_pos(level)
    @answer << 'B'
    true
  end

  def resolve_right(level_pos, level)
    return false unless level_pos == right_pos(level)
    @answer << 'C'
    true
  end

  def left_pos
    0
  end

  def center_pos(level)
    (@length[level] - @length[level] / 2)
  end

  def right_pos(level)
    @length[level]
  end

  private

  def prepare_text_length_by_level
    @length = { 1 => 3 }
    (2..@k).each do |level|
      @length[level] = @length[level - 1] * 2 + 3
    end
  end
end

if $PROGRAM_NAME == __FILE__
  k, s, t = STDIN.gets.split(' ')
  puts f(k, s, t)
end
