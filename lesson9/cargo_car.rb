# frozen_string_literal: true

class CargoCar < Car
  MIN_SPACE = 300
  MAX_SPACE = 500

  attr_reader :space, :space_taken
  validate :space, :presence
  validate :space, :type, Integer

  def initialize(space)
    @type = :cargo
    @space = space
    validate!
    correct_space!
    @space_taken = 0
  end

  def info
    "number: #{number}," \
    "type: #{type}," \
    "space_taken: #{space_taken}," \
    "space_free: #{space_free}"
  end

  def take_space(space_part)
    @space_taken += space_part if space_part.between?(0, space_free)
  end

  def space_free
    space - space_taken
  end

  private

  def correct_space!
    @space = MIN_SPACE if space < MIN_SPACE
    @space = MAX_SPACE if space > MAX_SPACE
  end
end
