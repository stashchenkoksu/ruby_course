require_relative 'creator'
class Wagon
  include Creator
  attr_accessor :type, :number
  @@serial_number = 1 # rubocop:disable Style/ClassVars
  def initialize
    @number = @@serial_number
    @@serial_number += 1 # rubocop:disable Style/ClassVars
  end
end
