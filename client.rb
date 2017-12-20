require 'socket'
require_relative 'libs/encrypt.rb'

def send_msg(sock, msg)
  data = msg
  sock.send(data, 0, '127.0.0.1', 33333)
end

sock = UDPSocket.new

key = 'secret1'

loop  do
	msg = gets.chomp.to_s
	cipher = msg.encrypt(key) 
	encrypted = Base64.encode64(cipher)

	send_msg(sock, encrypted)
end

sock.close

