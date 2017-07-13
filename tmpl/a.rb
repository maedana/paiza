def f(x)
end

if $PROGRAM_NAME == __FILE__
  x = STDIN.gets.to_i
  puts f(x)
end
