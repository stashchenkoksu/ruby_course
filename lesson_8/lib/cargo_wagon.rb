# frozen_string_literal: true

class CargoWagon < Wagon
  attr_accessor :free
  attr_reader :volume
  def initialize(volume)
    super()
    @volume = volume
    @type = :cargo
    @free = volume
  end

  def fill_space(amount)
    raise 'No free space for such volume' unless (free - amount).positive?

    @free -= amount
  rescue RuntimeError => e
    puts "Exeption: #{e.message}"
  end

  def filled
    volume - free
  end
end
