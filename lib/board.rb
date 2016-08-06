class Board
  attr_reader :width, :height

  def initialize(width, height)
   @width = width
   @height = height
  end

  def to_json
    "{\"width\":#{@width},\"height\":#{@height}}"
  end
end
