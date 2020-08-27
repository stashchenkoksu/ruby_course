letters = 'aeiouy'.split('')
arr = ('a'..'z').to_a
hash = {}
arr.each_with_index do |letter, index|
  hash[letter] = index + 1 if letters.include? letter
end
puts hash.to_s
