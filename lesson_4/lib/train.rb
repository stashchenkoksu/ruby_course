require_relative 'route'
require_relative 'station'
require_relative 'wagon'
class Train
  attr_reader :number, :type
  attr_accessor :route, :current_station, :tracks, :wagon, :speed
  def initialize(number, type)
    @number = number
    @type = type
    @tracks = []
    @speed = 0
    @route = nil
    @current_station = nil
    puts "Created train № #{number}. Type: #{type}. Tracks amount: #{tracks.size}."
  end

  def speed_up
    speed += speed_const
    puts 'train speed up'
  end

  def slow_down
    puts 'Train slow down'
    speed -= speed_const
    speed = 0 if speed.negative?
  end

  def attech_track track
    if speed.zero?
      tracks << track
      puts "amount of tracks : #{tracks.size}"
    else
      puts "train is mooving! you can't attach tracks"
    end
  end

  def unhook_track track
    if speed.zero?
      if tracks.size.positive?
        tracks.delete(track)
        puts "amount of tracks : #{tracks.size}"
      else
        puts "You can't delete wagon,becouse train doesn't have any"
      end
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

  def show_tracks
    puts "All wagons of train №#{number}"
    puts '----------'
    tracks.each_with_index do |track, index|
      puts "#{index}) Number: #{track.number} | type: #{type}"
    end
    puts '----------'
     end

  protected

  def speed_const
    20
  end
end
