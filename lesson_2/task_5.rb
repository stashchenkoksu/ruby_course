def leap(year)
  answer = (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

puts 'Enter three numbers (date, month, year)'

date = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

days_simple = [30, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day_count = 0
i = 1
while i <= month
  day_count += days_simple[i]
  i += 1
end
if leap(year) && month >= 2 || year == 2000
  puts 'im leap'
  day_count += 1
end
day_count -= (days_simple[month - 1] - date)
puts day_count
