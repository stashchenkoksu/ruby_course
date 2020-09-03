# triangle square

puts 'Enter triangle base'
base = STDIN.gets.chomp.to_i
puts 'Enter triangle hight'
t_hight = STDIN.gets.chomp.to_i
square = 0.5 * base * t_hight
puts square.to_s
