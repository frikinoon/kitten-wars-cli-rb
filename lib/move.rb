class Move
  attr_reader :direction

  def initialize(direction)
    raise ArgumentError unless [:up, :down, :left, :right].include?(direction);
    @direction = direction
  end

  def to_json(*args)
    "{direction:\"#{@direction[0]}\"}"
  end
end
