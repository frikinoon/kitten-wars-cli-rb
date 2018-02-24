ARROWS = {
  up:    ["\e", "[", "A"],
  down:  ["\e", "[", "B"],
  right: ["\e", "[", "C"],
  left:  ["\e", "[", "D"],
}
WASD_KEYS = %W(w a s d W A S D)
WASD_MOVES = {
  w: :up,
  s: :down,
  d: :right,
  a: :left,
}

module UnbufferedKeyboardHandler
  def initialize(ws)
    @ws = ws
    @buffer = Array.new(3)
  end

  def receive_data(data)
    @buffer.shift
    @buffer << data

    ARROWS.keys.each do |key|
      if @buffer == ARROWS[key]
        @ws.send key
        return
      end
    end

    WASD_KEYS.each do |key|
      if got_non_arrow_key(key)
        @ws.send WASD_MOVES[key.downcase.to_sym]
        return
      end
    end
  end

  private

  def got_non_arrow_key(key)
    @buffer.last == key && @buffer[-2] != "["
  end
end


