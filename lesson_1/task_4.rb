#Quadratic equation

puts 'Enter a, b, c:'
a = STDIN.gets.chomp.to_i
b = STDIN.gets.chomp.to_i
c = STDIN.gets.chomp.to_i

Dd = b * b - 4 * a * c
if Dd.negative?
 puts 'Negative discriminant the equitation has complex solution'
else
  D = Math.sqrt(Dd)
  if(D>0)
    puts "The equitation has tow solutions"
  else
    puts "the equitation has one solution"
  end
end