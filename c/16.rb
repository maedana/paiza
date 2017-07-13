def f(ips)
  ips.map do |ip|
    valid?(ip) ? 'True' : 'False'
  end.join("\n")
end

def valid?(ip)
  ip_nums = ip.split('.')
  ip_nums.size == 4 && ip_nums.all? { |num| (0..255).to_a.include?(num.to_i) }
end

if $PROGRAM_NAME == __FILE__
  x = STDIN.gets.to_i
  ips = []
  x.times do
    ips << STDIN.gets
  end
  puts f(ips)
end
