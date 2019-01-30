class Car
  include Manufacturer
  attr_reader :type

  def initialize
    @type = :unknown
  end
end
