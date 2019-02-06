class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
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

  private

  def validate!
    raise ArgumentError.new('Station can\'t be nil!') if stations_nil?
    raise ArgumentError.new('First and last stations must be different!') if stations_match?
  end

  def stations_nil?
    stations.compact.length != 2
  end

  def stations_match?
    stations.first == stations.last || stations.first.name == stations.last.name
  end
end
