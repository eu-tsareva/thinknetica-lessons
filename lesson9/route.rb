# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  validate :stations, :presence

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    validate_stations!
    register_instance
  end

  def add_station(station)
    return if stations.include?(station)

    stations.insert(-2, station)
  end

  def delete_station(index)
    return unless stations.size > 2 && (0...stations.size).cover?(index)

    stations.delete_at(index)
  end

  def show_stations
    stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  private

  def validate_stations!
    raise ArgumentError, 'Must be at least two stations!' unless stations_enough?
    raise ArgumentError, 'Stations must be different!' if stations_match?
  end

  def stations_enough?
    stations.compact.length >= 2
  end

  def stations_match?
    stations.first == stations.last || stations.first.name == stations.last.name
  end
end
