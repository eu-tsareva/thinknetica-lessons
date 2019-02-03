class Train
  include Manufacturer
  include InstanceCounter
  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  attr_reader :speed, :type, :number, :station

  @@trains = {}

  def self.find(train_number)
    @@trains[train_number]
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @type = :unknown
    @cars = []
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def accelerate(increase = 15)
    @speed += increase.positive? ? increase : 0
  end

  def stop
    @speed = 0
  end

  def add_car(car)
    @cars << car if still? && accept?(car.type)
  end

  def remove_last_car
    @cars.pop if still? && any_cars?
  end

  def cars_number
    @cars.size
  end

  def info
    "number: #{number}, type: #{type}, cars: #{cars_number}"
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

  def validate!
    raise ArgumentError.new('Wrong name format!') unless number =~ NUMBER_FORMAT
  end

  # to preserve encapsulation
  def station=(station)
    @station.delete_train(self)
    @station = station
    @station.add_train(self)
  end

  # still? accept? any_cars?
  # inner methods for internal usage only
  def still?
    speed.zero?
  end

  def accept?(car_type)
    type == car_type
  end

  def any_cars?
    @cars.any?
  end
end
