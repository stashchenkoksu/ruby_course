require_relative 'train'
require_relative 'route'
require_relative 'station'

station_kr1 = Station.new('Краснодар')
station_nvs = Station.new('Новороссийск')
station_sci = Station.new('Сочи')
station_gkl = Station.new('Горячий Ключ')
station_tps = Station.new('Туапсе')
station_sci = Station.new('Сочи')
station_adl = Station.new('Адлер')

route_kr1_sci = Route.new(station_kr1, station_sci)
route_kr1_sci.add_station(station_gkl)
route_kr1_sci.add_station(station_tps)
route_kr1_sci.station_list
route_kr1_sci.delete_station(station_kr1)
route_kr1_sci.delete_station(station_sci)
route_kr1_sci.delete_station(station_gkl)
route_kr1_sci.station_list

train1 = Train.new(1, 'passenger', 12)
train2 = Train.new(2, "cargo", 20)
train3 = Train.new(3,"passenger", 14)
train4 = Train.new(4, "cargo", 22)

train1.add_route(route_kr1_sci)

station_sci.show_train_type_of
station_tps.show_train_type_of

puts train1.current_station.station_name
train1.moove_to_the_next_statioin
puts train1.current_station.station_name
train1.moove_to_the_previous_station

station_tps.arrive_train(train2)
station_tps.arrive_train(train3)
station_tps.arrive_train(train4)

station_tps.show_train_type_of("cargo")
station_tps.show_train_type_of("passenger")

puts train1.current_station.station_name
train1.moove_to_the_next_statioin
puts train1.current_station.station_name

station_nvs.show_train_type_of('passenger')
station_tps.show_train_type_of('passenger')
