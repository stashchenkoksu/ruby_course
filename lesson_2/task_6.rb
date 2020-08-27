all_products = {}
loop do
  puts 'Enter product name, price, amount, if you want to exit enter stop'
  name = gets.chomp
  break if name == 'stop'

  price = gets.chomp.to_f
  amount = gets.chomp.to_f
  if all_products.key?(name)
    all_products[name][:amount] += amount
  else
    all_products[name] = { price: price, amount: amount }
  end
end
sum = 0
all_products.each_value { |value| sum += value[:price] * value[:amount] }
puts "sum is: #{sum}"
