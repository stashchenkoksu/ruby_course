puts 'Enter your name: '
name = STDIN.gets.chomp
puts 'Enter yout hight: '
hight = STDIN.gets.chomp.to_i
puts 'Enter your weight'
weight = STDIN.gets.chomp.to_i

ideal_weight = (hight - 110) * 1.15
if ideal_weight == weight || ideal_weight < 0
  puts name + ' your weight is ideal'
else
  puts name + ' your ideal weight is ' + ideal_weight.to_s
end
