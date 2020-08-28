require_relative 'train'
require_relative 'route'
class Station
  attr_reader :station_name
  attr_accessor :trains

  def initialize station_name
    @station_name = station_name
    @trains = []
    puts "Build station #{station_name}"
  end

  def arrive_train train
    puts "On station #{station_name} arrives train №#{train.number}"
    trains << train
  end

  def trains_on_station
    puts 'On station right now:'
    trains.each do |train|
      puts train.number
    end
  end

  def leave_station(train_number)
    puts "From #{station_name} station leave train №#{train_number}"
    trains.delete_if { |train| train_number == train.number }
  end

  def show_train_type_of(type = nil)
    if type
      puts "On the station #{station_name} trains type are: #{type}: "
      trains.each do |train|
        puts train.number if train.type == type
      end
    else
      puts "Trains on the station #{station_name}: "
      trains.each do |train|
        puts train.number
      end
       end
  end
end
