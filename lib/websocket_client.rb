require 'websocket-eventmachine-client'

EM.run do

  ws = WebSocket::EventMachine::Client.connect(:uri => 'ws://192.168.1.2:8765')

  ws.onopen do
    puts "Connected"
  end

  ws.onmessage do |msg, type|
    puts "Received message: #{msg}"
  end

  ws.onclose do |code, reason|
    puts "Disconnected with status code: #{code}"
  end

  EventMachine.next_tick do
    ws.send "Ruby"
    # ws.close code: 1000

  end

end
