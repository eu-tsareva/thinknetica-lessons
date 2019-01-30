class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    return if stations.include?(station)
    stations.insert(-2, station)
  end

  def delete_station(index)
    return unless stations.size > 2 && (0..stations.size - 1).include?(index)
    stations.delete_at(index)
  end

  def show_stations
    stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end
end
