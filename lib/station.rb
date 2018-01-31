class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end

def generate_stations
  stations_list = {}
  File.open("/Users/terenceallitt/Projects/oystercard-monday/lib/stations_list.txt", "r") do |f|
    f.each_line do |line|
      line_data = line.split(",")
      stations_list[line_data[0]] = line_data[1].to_i
    end
  end
  $stations = []
  stations_list.each do |k, v|
    $stations << Station.new(k, v)
  end
end
