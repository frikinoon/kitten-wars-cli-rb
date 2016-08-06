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
    EM.stop
  end

  EM.next_tick do
      ws.send "Ruby"
  end

  EM.add_timer 0.5 do
    ws.close 1000
  end

end
