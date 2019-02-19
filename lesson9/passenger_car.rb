# frozen_string_literal: true

class PassengerCar < Car
  MIN_SEATS = 36
  MAX_SEATS = 68

  attr_reader :seats, :seats_taken
  validate :seats, :presence
  validate :seats, :type, Integer

  def initialize(seats)
    @type = :passenger
    @seats = seats
    validate!
    @seats_taken = 0
    correct_seats!
  end

  def info
    <<~INFO
      number: #{number},
      type: #{type},
      seats_taken: #{seats_taken},
      seats_free: #{seats_free}
    INFO
  end

  def take_seat
    @seats_taken += 1 if seats_free.positive?
  end

  def seats_free
    @seats - seats_taken
  end

  private

  def correct_seats!
    @seats = MIN_SEATS  if seats < MIN_SEATS
    @seats = MAX_SEATS   if seats > MAX_SEATS
  end
end
