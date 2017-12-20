require 'socket'
require_relative 'libs/encrypt.rb'

BasicSocket.do_not_reverse_lookup = true
client = UDPSocket.new
client.bind('0.0.0.0', 8090)

key = 'secret'

loop do
  data, _addr = client.recvfrom(1024)
  plain = Base64.decode64(data)
  msg = plain.decrypt(key)

  puts msg
end

client.close
