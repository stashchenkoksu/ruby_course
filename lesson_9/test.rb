require_relative 'accessor'
require_relative 'validation'
class User
  extend Accessors
  include Validation
  attr_accessor_with_history :name, :serial_number
  strong_attr_accessor :birth_year, Integer

  validate :name, :presence
  validate :serial_number, :format, /^[\d\w]{3}-[\d]{2}-[\w]$/i
  validate :birth_year, :type, Integer
end

user = User.new

user.name = 'Kate'
user.serial_number = '005-16-w'
user.birth_year = 2005

puts 'All checks passed successfully' if user.valid?

user.name = 'Liz'
user.name = 'Doris'

puts user.name_history.to_s

user.serial_number = '222-25-m'

puts user.valid? ? 'All checks passed successfully' : 'There is a mistake somewhere'
user.validate!
