# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  attr_reader :speed, :type, :number, :station, :cars

  @trains = {}

  class << self
    attr_reader :trains

    def find(train_number)
      trains[train_number]
    end
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @type = :unknown
    @cars = []
    self.class.trains[number] = self
    register_instance
  end

  def accelerate(increase = 15)
    @speed += increase.positive? ? increase : 0
  end

  def stop
    @speed = 0
  end

  def add_car(car)
    return unless still? && accept?(car.type)

    car.number = generate_car_number
    cars << car
  end

  def remove_last_car
    cars.pop if still? && @cars.any?
  end

  def cars_number
    cars.size
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
    return if index == @route.stations.size - 1 || index.nil?

    @route.stations[index + 1]
  end

  def go_forwards
    self.station = next_station if next_station
  end

  def go_backwards
    self.station = prev_station if prev_station
  end

  def each_car
    cars.each { |car| yield(car) }
  end

  def each_car_with_index
    cars.each.with_index(1) { |car, index| yield(car, index) }
  end

  private

  def validate!
    raise ArgumentError, 'Wrong number format!' unless number =~ NUMBER_FORMAT
  end

  # to preserve encapsulation
  def station=(station)
    @station.delete_train(self)
    @station = station
    @station.add_train(self)
  end

  # still? accept?
  # inner methods for internal usage only
  def still?
    speed.zero?
  end

  def accept?(car_type)
    type == car_type
  end

  def generate_car_number
    cars_number + 1
  end
end
