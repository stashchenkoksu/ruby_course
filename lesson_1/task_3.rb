# triangle type

def is_triangle?(a, b, c)
  a + b > c && b + c > a && a + c > b
end

def get_type(a, b, c)
  equilateral = false
  isosceles = false
  rectangular = false

  if a == b && b == c
    equilateral = true
    longest = a
    other1 = b
    other2 = c
  elsif b > a && b > c
    longest = b
    other1 = a
    other2 = c
  else
    longest = c
    other1 = a
    other2 = b
  end

  rectangular = true if longest**2 == other1**2 + other2**2
  isosceles = true if other1 == other2

  puts 'equilateral - ' + equilateral.to_s
  puts 'isosceles - ' + isosceles.to_s
  puts 'rectangular - ' + rectangular.to_s
end

puts 'Enter the sides of triangle'
a = STDIN.gets.chomp.to_i
b = STDIN.gets.chomp.to_i
c = STDIN.gets.chomp.to_i

if is_triangle?(a, b, c)
  get_type(a, b, c)
else
  puts "you can't make a triangle with such sides"
end
