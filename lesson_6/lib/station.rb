require_relative 'train'
require_relative 'route'
require_relative 'instance_counter'
require_relative 'valid'
class Station
  include InstanceCounter
  include Valid
  attr_reader :station_name
  attr_accessor :trains, :all_created_stations

  @@all_created_stations = []

  def initialize station_name
    @station_name = station_name
    @trains = []
    valid!
    @@all_created_stations << self
    register_instance
    puts "Build station #{station_name}"
  end
  STATION_RGEX = /\w{2,}/i.freeze

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
    trains << train
  end

  def trains_on_station
    puts 'On station right now:'
    trains.each do |train|
      puts train.number
    end
  end

  def leave_station(train_number)
    raise "train with such number doesn't exists" if Train.find(train_number).nil?

    trains.delete(Train.find(train_number))
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

  private

  def valid!
    raise 'Wrong station name, it should be at list 2 simbols' if station_name !~ STATION_RGEX
  end
end
