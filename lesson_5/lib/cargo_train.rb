require_relative 'train'
require_relative 'wagon'
require_relative 'passanger_wagon'
require_relative 'cargo_wagon'

class CargoTrain < Train
  def attech_track(track)
    if track.type == 'cargo'
      super
    else
      puts "You can't attach not cargo wagon to this train"
   end
  end
end
