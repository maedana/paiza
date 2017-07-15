def f(h, w, boxes_text)
  mirror_box = MirrorBox.new(h, w, boxes_text)
  mirror_box.attack
  mirror_box.count
end

class MirrorBox
  attr_reader :count

  def initialize(h, w, boxes_text)
    @h = h.to_i
    @w = w.to_i
    @boxes_text = boxes_text
    prepare_boxes
    @current_pos_x = 0
    @current_pos_y = 0
    @count = 0
    @current_direction = :e # 東西南北(ewsn)
  end

  def attack
    @count += 1 while go_next
  end

  def go_next
    # puts "x: #{@current_pos_x}, y: #{@current_pos_y}, d: #{@current_direction}"
    case current_box
    when '_'
      case @current_direction
      when :n
        @current_pos_y -= 1
      when :e
        @current_pos_x += 1
      when :s
        @current_pos_y += 1
      when :w
        @current_pos_x -= 1
      end
    when '\\'
      case @current_direction
      when :n
        @current_pos_x -= 1
        @current_direction = :w
      when :e
        @current_pos_y += 1
        @current_direction = :s
      when :s
        @current_pos_x += 1
        @current_direction = :e
      when :w
        @current_pos_y -= 1
        @current_direction = :n
      end
    when '/'
      case @current_direction
      when :n
        @current_pos_x += 1
        @current_direction = :e
      when :e
        @current_pos_y -= 1
        @current_direction = :n
      when :s
        @current_pos_x -= 1
        @current_direction = :w
      when :w
        @current_pos_y += 1
        @current_direction = :s
      end
    end
  end

  def current_box
    return nil if @current_pos_x.negative? || @current_pos_y.negative?
    @boxes[@current_pos_y]&.[](@current_pos_x)
  end

  private

  def prepare_boxes
    @boxes = @boxes_text.split("\n").map {|l| l.split('') }
  end
end

if $PROGRAM_NAME == __FILE__
  h, w = STDIN.gets.split(' ')
  boxes_text = STDIN.readlines.join('')
  puts f(h, w, boxes_text)
end
