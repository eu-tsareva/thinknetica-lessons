class PassengerCar < Car
  attr_reader :seats_taken
  MIN_SEATS = 36
  MAX_SEATS = 68

  def initialize(seats)
    @type = :passenger
    @seats = seats
    validate!
    @seats_taken = 0
  end

  def info
    "number: #{number}, type: #{type}, seats_taken: #{seats_taken}, seats_free: #{seats_free}"
  end

  def take_seat
    @seats_taken += 1 if seats_free > 0
  end

  def seats_free
    @seats - seats_taken
  end

  private

  def validate!
    raise ArgumentError.new("Number of seats should be between #{MIN_SEATS} and #{MAX_SEATS}!") unless (MIN_SEATS..MAX_SEATS).include?(@seats)
  end
end
