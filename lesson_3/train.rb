require_relative 'route'
require_relative 'station'
class Train
  attr_reader :amount_of_tracks, :number, :type
  attr_accessor :route, :current_station
  def initialize(number, type, amount_of_tracks)
    @number = number
    @type = type
    @amount_of_tracks = amount_of_tracks
    @speed = 0
    @route = nil
    @current_station = nil
    puts "Created train № #{number}. Type: #{type}. Tracks amount: #{amount_of_tracks}."
  end

  def speed_up
    speed += 20
    puts 'train speed up'
  end

  def slow_down
    puts 'Train slow down'
    speed -= 20
    speed = 0 if speed < 0
  end

  def attech_track
    if speed.zero?
      amount_of_tracks += 1
    else
      puts "train is mooving! you can't attach tracks"
    end
  end

  def unhook_track
    if speed.zero?
      amount_of_tracks -= 1
      amount_of_tracks = 0 if amount_of_tracks.negative?
    else
      puts "train is mooving! you can't unhook tracks"
    end
  end

  def add_route(new_route)
    puts "previous route: #{route}"
    puts "new route: #{new_route}"
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
    if route.nil?
      puts "this train doesn't have a route yet"
    elsif current_station != route.end_station
      current_station.leave_station(number)
      self.current_station = route.inner_stations[route.inner_stations.index(current_station) + 1]
      p
      current_station.arrive_train self
      puts "next station #{current_station.station_name}"
    else
      puts "You can't go to the next station, this train is alredy on the last station"
    end
  end

  def moove_to_the_previous_station
    if route.nil?
      puts "this train doesn't have a route yet"
    elsif current_station != route.start_station
      current_station&.leave_station(number)
      self.current_station = route.inner_stations[(route.inner_stations.index(current_station) - 1)]
      current_station.arrive_train self
      puts "next station #{current_station.station_name}"

    else
      puts "You can't go to the previous station, this train is alredy on the first station"
    end
  end
end
