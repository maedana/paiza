def f(count, logs_text)
  osero = Osero.new(count, logs_text)
  osero.run
  osero.result
end

class Osero
  attr_reader :board, :count, :logs

  W = 'W'.freeze
  B = 'B'.freeze

  def initialize(count, logs_text)
    @board = Array.new(8, ' ') { Array.new(8, ' ') }
    @board[3][3] = W
    @board[3][4] = B
    @board[4][3] = B
    @board[4][4] = W
    @count = count
    prepare_logs(logs_text)
  end

  def run
    @count.times do |index|
      put_stone(index)
    end
  end

  def result
    w_count = @board.map { |line| line.select { |stone| stone == W }.size }.inject(:+)
    b_count = @board.map { |line| line.select { |stone| stone == B }.size }.inject(:+)
    if w_count > b_count
      "#{'%02d' % b_count}-#{'%02d' % w_count} The white won!"
    elsif w_count < b_count
      "#{'%02d' % b_count}-#{'%02d' % w_count} The black won!"
    else
      "#{'%02d' % b_count}-#{'%02d' % w_count} Draw!"
    end
  end

  def put_stone(index)
    attack(index)
    # require 'pp'
    # puts "=====================================\n"
    # pp logs[index]
    # pp @board
    # puts "=====================================\n"
  end

  def attack(index)
    @stone, @x, @y = logs[index]
    @board[@y][@x] = @stone
    # 9方向全てについてチャレンジ
    turn_n
    turn_ne
    turn_e
    turn_se
    turn_s
    turn_sw
    turn_w
    turn_nw
  end

  def turn_n
    turn(y_increase: -1)
  end

  def turn_ne
    turn(x_increase: 1, y_increase: -1)
  end

  def turn_e
    turn(x_increase: 1)
  end

  def turn_se
    turn(x_increase: 1, y_increase: 1)
  end

  def turn_s
    turn(y_increase: 1)
  end

  def turn_sw
    turn(x_increase: -1, y_increase: 1)
  end

  def turn_w
    turn(x_increase: -1)
  end

  def turn_nw
    turn(x_increase: -1, y_increase: -1)
  end

  def turn(x_increase: 0, y_increase: 0)
    try_board = Marshal.load(Marshal.dump(@board))
    x = @x
    y = @y
    loop do
      x += x_increase
      y += y_increase
      if x.negative? || y.negative?
        break
      end
      if try_board[y]&.[](x).nil? || try_board[y][x] == ' '
        break
      end
      if same?(try_board[y][x])
        @board = try_board
        break
      end
      if different?(try_board[y][x])
        try_board[y][x] = @stone
      end
    end
  end

  def same?(target_stone)
    (@stone == W && target_stone == W) || (@stone == B && target_stone == B)
  end

  def different?(target_stone)
    (@stone == W && target_stone == B) || (@stone == B && target_stone == W)
  end

  private

  def prepare_logs(logs_text)
    @logs = logs_text.split("\n").map do |log_text|
      log_text.split(' ')
    end.map { |stone, x, y| [stone, x.to_i - 1, y.to_i - 1] }
  end
end

if $PROGRAM_NAME == __FILE__
  count = STDIN.gets.to_i
  logs_text = STDIN.readlines.join('')
  puts f(count, logs_text)
end
