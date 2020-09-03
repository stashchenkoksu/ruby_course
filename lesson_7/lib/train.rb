require_relative 'route'
require_relative 'station'
require_relative 'wagon'
require_relative 'creator'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  include Valid
  include Creator
  include InstanceCounter
  attr_reader :number, :type
  attr_accessor :route, :current_station, :tracks, :wagon, :speed, :all_trains

  @@all_trains = []
  def initialize(number, type)
    @number = number
    @type = type
    @tracks = []
    @speed = 0
    @route = nil
    @current_station = nil
    valid!
    @@all_trains << self
    register_instance
    puts "Created train № #{number}. Type: #{type}. Tracks amount: #{tracks.size}."
  end

  TRAIN_NUMBER = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/i.freeze

  def to_block_wagon(&block)
    raise 'No wagons in train' if tracks.nil?

    tracks.each { |track| block.call(track) }
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def self.find train_number
    @@all_trains.each do |train|
      return train if train.number == train_number
    end
    nil
  end

  def speed_up
    speed += speed_const
  end

  def slow_down
    speed -= speed_const
    speed = 0 if speed.negative?
  end

  def attech_track track
    raise 'train is mooving! you can\'t attach tracks' unless speed.zero?

    tracks << track
  end

  def unhook_track track
    raise 'train is mooving! you can\'t attach tracks' unless speed.zero?

    raise 'you can\'t unhook wagon, this train doesn\'t have any'

    tracks.delete(track)
    puts "amount of tracks : #{tracks.size}"
  end

  def add_route(new_route)
    if route.nil?
      self.route = new_route
      route.start_station.arrive_train(self)
      self.current_station = new_route.start_station
    else
      current_station.leave_station(number)
      self.route = new_route
      current_station = route.start_station
      current_station.arrive_train(self)
    end
    puts " the route #{route.start_station.station_name} - #{route.end_station.station_name} appoint to the train №#{number} "
    puts "current_station : #{self.current_station.station_name}"
  end

  def moove_to_the_next_statioin
    raise "this train doesn't have a route yet" if route.nil?
    if current_station == route.end_station
      raise "You can't go to the next station, this train is alredy on the last station"
    end

    current_station.leave_station(number)
    self.current_station = route.inner_stations[route.inner_stations.index(current_station) + 1]
    current_station.arrive_train self
    puts "next station #{current_station.station_name}"
  end

  def moove_to_the_previous_station
    raise "this train doesn't have a route yet" if route.nil?
    if current_station == route.end_station
      raise "You can't go to the previous station, this train is alredy on the first station"
    end

    current_station&.leave_station(number)
    self.current_station = route.inner_stations[(route.inner_stations.index(current_station) - 1)]
    current_station.arrive_train self
    puts "next station #{current_station.station_name}"
  end

  def show_tracks
    puts "All wagons of train №#{number}"
    puts '----------'
    to_block_wagon { |wagon| puts "#{wagon.number} #{wagon.type}  #{wagon.filled}/#{wagon.free}" }
    puts '----------'
  end

  protected

  def valid!
    raise 'No train number' if number.nil?
    raise 'No train type' if type.nil?
    raise 'Invalid format of train number(*****/***-**)' if number.to_s !~ TRAIN_NUMBER
    raise "Поезд № #{number} уже существует" unless Train.find(number).nil?
  end

  def speed_const
    20
  end
end
