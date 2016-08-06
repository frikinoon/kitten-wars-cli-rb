require 'websocket-eventmachine-client'
require 'json'

class KeyboardHandler < EM::Connection
  include EM::Protocols::LineText2

  def initialize(ws)
    @ws = ws
  end

  def require_data(data)
    puts data
  end
  def receive_line(data)
    @ws.close if data.chomp[/^$|^\s+$|exit$/]
    @ws.send data
  end

end


EM.run do

  host = "192.168.1.2"
  port = 8080
  ws = WebSocket::EventMachine::Client.connect(host: host, port: port)
  EM.open_keyboard(KeyboardHandler, ws)

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
