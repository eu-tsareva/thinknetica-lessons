class CargoCar < Car
  attr_reader :space_taken
  MIN_SPACE = 300
  MAX_SPACE = 500

  def initialize(space)
    @type = :cargo
    @space = space
    validate!
    @space_taken = 0
  end

  def info
    "number: #{number}, type: #{type}, space_taken: #{space_taken}, space_free: #{space_free}"
  end

  def take_space(space)
    @space_taken += space if (0..space_free).include?(space)
  end

  def space_free
    @space - space_taken
  end

  private

  def validate!
    raise ArgumentError.new("Space volume should be between #{MIN_SPACE} and #{MAX_SPACE}!") unless (MIN_SPACE..MAX_SPACE).include?(@space)
  end
end
