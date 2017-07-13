def f(x, y)
  puts x * y
end

if $PROGRAM_NAME == __FILE__
  x = STDIN.gets.to_i
  y = STDIN.gets.to_i
  puts f(x, y)
end
