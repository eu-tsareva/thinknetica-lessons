# frozen_string_literal: true

class CargoCar < Car
  MIN_SPACE = 300
  MAX_SPACE = 500

  attr_reader :space_taken

  def initialize(space)
    @type = :cargo
    @space = space
    validate!
    @space_taken = 0
  end

  def info
    <<~INFO
      number: #{number},
      type: #{type},
      space_taken: #{space_taken},
      space_free: #{space_free}
    INFO
  end

  def take_space(space)
    @space_taken += space if (0..space_free).cover?(space)
  end

  def space_free
    @space - space_taken
  end

  private

  def validate!
    return if (MIN_SPACE..MAX_SPACE).cover?(@space)

    raise ArgumentError,
          "Space should be between #{MIN_SPACE} and #{MAX_SPACE}!"
  end
end
