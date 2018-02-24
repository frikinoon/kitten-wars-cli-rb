require 'termios'
require 'websocket-eventmachine-client'
require_relative 'unbuffered_keyboard_handler.rb'

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
