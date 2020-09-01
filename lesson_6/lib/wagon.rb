require_relative 'creator'
require_relative 'valid'
class Wagon
  include Valid
  include Creator
  attr_accessor :type, :number
  @@serial_number = 1
  def initialize
    @number = @@serial_number
    valid!
    @@serial_number += 1
  end

  private 
  def valid!
  	raise 'No wagon type' if type.nil? 
  end
end
