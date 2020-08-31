require_relative 'train'
require_relative 'route'
require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :station_name
  attr_accessor :trains, :all_created_stations

  @@all_created_stations = []

  def initialize station_name
    @station_name = station_name
    @trains = []
    @@all_created_stations << self
    register_instance
    puts "Build station #{station_name}"
  end

  def self.all
    puts '------------------'
    puts '   All stations'
    puts '------------------'
    all_created_stations.each_with_index do |_station, index|
      puts "#{index}) station.station_name"
    end
    puts '------------------'
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
