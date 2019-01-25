class Train
  attr_accessor :speed
  attr_reader :cars_number
  attr_reader :type
  attr_reader :number
  attr_reader :station

  def initialize(number, type, cars_number)
    @number = number
    @type = type
    @cars_number = cars_number
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_car
    @cars_number += 1 if speed.zero?
  end

  def remove_car
    @cars_number -= 1 if speed.zero? && cars_number.positive?
  end

  def route=(route)
    @route = route
    @station = route.stations.first
    @station.add_train(self)
  end

  def prev_station
    return unless @route
    index = @route.stations.index(station)
    @route.stations[index - 1] unless index.zero? || index.nil?
  end

  def next_station
    return unless @route
    index = @route.stations.index(station)
    @route.stations[index + 1] unless index == @route.stations.size - 1 || index.nil?
  end

  def go_forwards
    self.station = next_station if @route && next_station
  end

  def go_backwards
    self.station = prev_station if @route && prev_station
  end

  private

  def station=(station)
    @station.delete_train(self)
    @station = station
    @station.add_train(self)
  end
end
