require_relative "stations_list"

class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def generate_stations
    File.open("./station_list.rb", "r") do |f|
      f.each_line do |line|
        
      end
    end
  end

end
