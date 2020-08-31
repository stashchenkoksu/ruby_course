require_relative 'train'
require_relative 'station'
require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :start_station, :end_station
  attr_accessor :inner_stations
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    register_instance
    @inner_stations = [start_station, end_station]
  end

  def add_station(station)
    puts "To the  #{start_station.station_name} - #{end_station.station_name} route #{station.station_name} station added"
    inner_stations.insert(-2, station)
  end

  def delete_station station
    if [inner_stations.first, inner_stations.last].include?(station)
      puts "You can't removethe first and the last stations"
    else
      inner_stations.delete(station)
      puts "From #{inner_stations.first.station_name} - #{inner_stations.last.station_name} route #{station.station_name} station deleted"
      end
  end

  def station_list
    puts "first station #{start_station.station_name}"
    inner_stations.each { |station| puts station.station_name }
    puts "last station #{end_station.station_name}"
  end
end
