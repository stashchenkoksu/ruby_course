class PassengerWagon < Wagon
  attr_accessor :free
  attr_reader :amount_of_seats
  def initialize amount_of_seats
    super()
    @amount_of_seats = amount_of_seats
    @type = :passenger
    @free = amount_of_seats
  end

  def filled
    amount_of_seats - free
  end

  def take_a_seat
    raise 'All places are already taken' if free.zero?

    @empty_seats -= 1
  rescue RuntimeError => e
    puts "Exeption: #{e.message}"
  end
end
