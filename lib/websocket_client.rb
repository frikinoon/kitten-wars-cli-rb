require 'termios'
require 'websocket-eventmachine-client'

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
      end
    end

    WASD_KEYS.each do |key|
      if got_non_arrow_key(key)
        @ws.send WASD_MOVES[key.downcase.to_sym]
      end
    end
  end

  private

  def got_non_arrow_key(key)
    @buffer.last == key && @buffer[-2] != "["
  end
end


EM.run do

  host = "192.168.1.131"
  port = 8080
  path = "/board"
  ws = WebSocket::EventMachine::Client.connect(:uri => "ws://#{host}:#{port}#{path}")

  attributes = Termios.tcgetattr($stdin).dup
  attributes.lflag &= ~Termios::ECHO # Optional.
  attributes.lflag &= ~Termios::ICANON
  Termios::tcsetattr($stdin, Termios::TCSANOW, attributes)

  EM.open_keyboard(UnbufferedKeyboardHandler, ws)

  ws.onopen do
    puts "Connected"
  end

  ws.onmessage do |msg, type|
    puts "Received message: #{msg}"
  end

  ws.onclose do |code, reason|
    puts "Disconnected with status code: #{code}"
    puts "Reason: #{reason}" unless reason.empty?
    EM.stop
  end

end
