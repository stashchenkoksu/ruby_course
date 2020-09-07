require_relative 'train'
require_relative 'route'
require_relative 'instance_counter'
require_relative 'valid'
class Station
  include InstanceCounter
  include Valid
  attr_reader :station_name
  attr_accessor :trains, :all_created_stations

  @@all_created_stations = [] # rubocop:disable Style/ClassVars

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    valid!
    @@all_created_stations << self
    register_instance
  end

  def to_block_train(&block)
    raise 'No trains on stations' if trains.nil?

    trains.each do |train|
      block.call(train)
      train.show_tracks
    end
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
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

  def arrive_train(train)
    trains << train
  end

  def trains_on_station
    puts "All trains at station #{station_name}:"
    to_block_train { |train| puts "##{train.number} #{train.class}. Wagons amount: #{train.tracks.size}" }
  end

  def leave_station(train_number)
    raise "train with such number doesn't exists" if Train.find(train_number).nil?

    trains.delete(Train.find(train_number))
  end

  def show_train_type_of(type = nil)
    if type
      puts "On the station #{station_name} trains type are: #{type}: "
      trains.each { |train| puts train.number if train.type == type }
    else
      puts "Trains on the station #{station_name}: "
      trains.each do |train|
        puts train.number
      end
    end
  end

  private

  def valid!
    raise 'Wrong station name, it shouldn\'t be empty' if station_name.empty?
  end
end
