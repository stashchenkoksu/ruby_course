require_relative 'train'
require_relative 'station'
require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include Valid
  attr_reader :start_station, :end_station
  attr_accessor :inner_stations
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    valid!
    register_instance
    @inner_stations = [start_station, end_station]
  end

  def add_station(station)
    inner_stations.insert(-2, station)
  end

  def delete_station(station)
    if [inner_stations.first, inner_stations.last].include?(station)
      raise "You can't removethe first and the last stations"
    end

    inner_stations.delete(station)
  end

  def station_list
    inner_stations.each { |station| puts station.station_name }
  end

  private

  def valid!
    raise 'No start station' if start_station.nil?
    raise 'No finish station' if end_station.nil?
  end
end
