require_relative 'train'
require_relative 'Passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passanger_wagon'

class Controller
  attr_accessor :stations, :trains, :routs
  TRAINS_TYPES = { cargo: CargoTrain, passenger: PassengerTrain }.freeze
  WAGONS_TYPES = { cargo: CargoWagon, passenger: PassengerWagon }.freeze

  def initialize
    @trains = []
    @routs = []
    @stations = []
  end

  def run
    loop do
      print_menu
      choice = gets.chomp.to_i
      break if choice.zero?

      case choice
      when 1
        create_stations
      when 2
        create_trains
      when 3
        create_routs
      when 4
        assign_route
      when 5
        add_wagon
      when 6
        unhook_wagon
      when 7
        moove_train
      when 8
        station_list
      when 9
        show_all_data
      when 10
        manage_wagon_space
      end
    end
  end

  private

  def print_menu
    string = File.open('./assets/menu.txt', 'r', &:read)
    puts string
   end

  def create_stations
    puts 'You choose to add station'
    loop do
      begin
        print 'Enter station name: '
        station_name = gets.chomp
        station = Station.new(station_name)
      rescue Exception => e
        puts "Error: #{e.message}"
        retry
      end
      stations << station
      puts 'Station added succesful!'
      print 'Do you want to add another station (Yes: enter 1/ No: enter 0)?'
      answer = gets.chomp.to_i
      break if answer.zero?
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
   end

  def create_trains
    puts 'You choose to create the train'
    loop do
      begin
        puts "Indicate the type of train. Available trains: #{TRAINS_TYPES.keys}"
        type = gets.chomp.to_sym
        print 'Enter the number of train: '
        number = gets.chomp.to_i
        train = Train.new(number, type)
      rescue Exception => e
        puts "Error: #{e.message}"
        retry
      end
      print 'Enter manufactor name:'
      manufactor = gets.chomp
      train.creator_name = manufactor
      train.print_creator
      trains << train
      print 'Do you want to create another train? (Yes: enter 1/ No: enter 0)?'
      answer = gets.chomp.to_i
      break if answer.zero?
    end
  end

  def create_routs
    puts 'You choose to create route'
    print_all_stations
    puts 'Choose the number of first station of new route'
    first_station = gets.chomp.to_i
    puts 'Choose the number last station of new route'
    last_station = gets.chomp.to_i
    unless first_station.between?(1, stations.size) && last_station.between?(1, stations.size)
      raise "Station, wich you input doesn't exists"
    end

    new_route = Route.new(stations[first_station - 1], stations[last_station - 1])
    inner_stations_controller(new_route)
    routs << new_route
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def inner_stations_controller new_route
    puts 'you can add inner stations in your route'
    print_all_stations
    loop do
      puts 'Do you want to add or delete inner station (add: enter 1/ delete: enter -1/ do nothing: enter 0)?'
      answer = gets.chomp.to_i
      break if answer.zero? || !answer.between?(-1, 1)

      puts 'Enter the number of station, wich you want to manage'
      inner_station = gets.chomp.to_i
      answer == 1 ? new_route.add_station(stations[inner_station - 1]) : new_route.delete_station(stations[inner_station - 1])
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def assign_route
    puts 'You choose to assign route for the train'
    train = choose_train
    return if train.nil?

    puts 'Choose number route for assigning'
    print_all_routs
    choice = gets.chomp.to_i
    raise 'You entered incorrect data of route' unless choice.between?(1, routs.size)

    new_route = routs[choice - 1]
    train.add_route(new_route)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
   end

  def add_wagon
    puts 'You choose to add wagon to train'
    train = choose_train
    return if train.nil?

    loop do
      print 'enter amount of wagon volume: ' if train.type == :cargo
      print 'enter amount of seats in wagon: ' if train.type == :passenger
      data = gets.chomp.to_i
      wagon = WAGONS_TYPES[train.type.to_sym].new(data)
      print 'Enter manufactor name:'
      manufactor = gets.chomp
      wagon.creator_name = manufactor
      train.attech_track wagon
      puts 'Do you want to add another wagon to the train (yes: enter 1/ no: enter 0)'
      answer = gets.chomp.to_i
      break if answer.zero?
    end
   end

  def unhook_wagon
    puts 'You choose to add wagon to train'
    train = choose_train
    return if train.nil?

    loop do
      puts 'choose a wagon to remove:'
      train.show_tracks
      number = gets.chomp.to_i
      raise 'you entered incorrect data of wagon' unless number.between?(1, train.tracks.size)

      train.unhook_track(train.tracks[number - 1])
      puts 'Do you whant to remoove another wagon to the train (yes: enter 1/ no: enter 0)'
      answer = gets.chomp.to_i
      break if answer.zero?
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
   end

  def moove_train
    puts 'You choose to moove train'
    train = choose_train
    return if train.nil?

    puts 'Where do you want to go forward or backward?(1/-1)'
    choice = STDIN.gets.chomp.to_i
    choice.positive? ? train.moove_to_the_next_statioin : train.moove_to_the_previous_station
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
   end

  def station_list
    Station.all
    puts 'Would you like to see train list at the specific station(yes: enter 1/ no: enter 0)?'
    choice = STDIN.gets.chomp.to_i
    return if choice.zero?

    puts 'Choose a station number'
    choice = STDIN.gets.chomp.to_i
    raise 'You entered incorrect data!' unless choice.between?(1, stations.size)

    station = stations[choice - 1]
    station.show_train_type_of
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def choose_train
    print_all_train
    print 'Choose the nunber of train to manage: '
    number = gets.chomp.to_i
    raise 'you entered incorrect data of train' if Train.find(number).nil?

    Train.find(number)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def choose_wagon(train)
    train.show_tracks
    print 'Choose the nunber of track to manage: '
    number = gets.chomp.to_i
    raise 'you entered incorrect data of wagon' unless number.between?(1, train.tracks.size)

    train.tracks[number - 1]
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def manage_wagon_space
    print 'Choose the nunber of train to manage: '
    train = choose_train
    puts 'Choose the wagon to manage '
    wagon = choose_wagon(train)
    if wagon.type == :cargo
      puts "How many spase do youo whant to occupie? (between 0 and #{wagon.free}) "
      data = gets.chomp.to_i
      wagon.fill_space(data)
    elsif wagon.type == :passenger
      wagon.take_a_seat
    end
  end

  def print_all_train
    puts '------------------'
    puts '   All trains'
    puts '------------------'
    trains.each_with_index do |train, index|
      puts "#{index + 1}. train№ #{train.number}, manufactor :#{train.creator_name}"
    end
    puts '------------------'
   end

  def print_all_stations
    puts '------------------'
    puts '   All stations'
    puts '------------------'
    stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.station_name}"
    end
    puts '------------------'
 end

  def print_all_routs
    puts '------------------'
    puts '   All routs'
    puts '------------------'
    routs.each_with_index do |route, index|
      puts "#{index + 1}. route: #{route.start_station.station_name} - #{route.end_station.station_name}"
      puts 'All station of this route'
      puts '-------------'
      route.station_list
      puts '-------------'
    end
    puts '------------------'
   end

  def show_all_data
    stations.each_with_index do |station, index|
      puts "#{index + 1}) #{station.station_name}"
      station.trains_on_station
    end
  end
end
