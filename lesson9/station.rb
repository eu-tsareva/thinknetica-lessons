# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  @stations = []

  def self.all
    @stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.all << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def each_train_with_index
    trains.each.with_index(1) { |train, index| yield(train, index) }
  end

  private

  def validate!
    return if name.length >= 2

    raise ArgumentError, 'Station name is less than 2 characters!'
  end
end
