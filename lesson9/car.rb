# frozen_string_literal: true

class Car
  extend Accessors
  include Validation
  include Manufacturer

  attr_reader :type
  strong_attr_accessor :number, Integer

  def initialize
    @type = :unknown
  end
end
