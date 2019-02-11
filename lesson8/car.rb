# frozen_string_literal: true

class Car
  include Manufacturer
  include Validation

  attr_reader :type
  attr_accessor :number

  def initialize
    @type = :unknown
  end
end
