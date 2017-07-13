def f(card_numbers)
  results = []
  card_numbers.each do |card_number|
    nums = card_number.chomp.split('').reverse.map(&:to_i)
    nums.shift
    (0..9).each do |x|
      _nums = [x] + nums
      if check?(_nums, x)
        results << x
        break
      end
    end
  end
  results.join("\n")
end

def check?(nums, x)
  even = 0
  odd = 0
  nums.each_slice(2) do |odd_num, even_num|
    odd += odd_num
    _even_num = (even_num * 2)
    even +=
      if _even_num > 9
        _even_num.to_s.split('').map(&:to_i).inject(:+)
      else
        _even_num
      end
  end
  ((even + odd) % 10).zero?
end

if $PROGRAM_NAME == __FILE__
  x = STDIN.gets.to_i
  card_numbers = []
  x.times do
    card_numbers << STDIN.gets
  end
  puts f(card_numbers)
end
