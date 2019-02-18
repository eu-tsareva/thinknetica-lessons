# frozen_string_literal: true

class PassengerCar < Car
  MIN_SEATS = 36
  MAX_SEATS = 68

  attr_reader :seats_taken

  def initialize(seats)
    @type = :passenger
    @seats = seats
    validate!
    @seats_taken = 0
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

  def validate!
    return if (MIN_SEATS..MAX_SEATS).cover?(@seats)

    raise ArgumentError,
          "Number of seats should be between #{MIN_SEATS} and #{MAX_SEATS}!"
  end
end
