months = {
  'January' => 30,
  'Fabuary' => 29,
  'March' => 31,
  'April' => 30,
  'May' => 31,
  'june' => 30,
  'july' => 31,
  'August' => 31,
  'September' => 30,
  'Oktober' => 31,
  'November' => 30,
  'Desember' => 31
}

months.each do |key, value|
  puts key if value == 30
end
