require_relative 'train'
require_relative 'wagon'
require_relative 'passanger_wagon'
require_relative 'cargo_wagon'

class PassengerTrain < Train

def attech_track track
   	if track.type == "passenger"
    	super
    else
    	puts "You can't attach not passenger wagon to this train"
    end
end
end