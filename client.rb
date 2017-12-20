require 'socket'
require_relative 'libs/encrypt.rb'

sock = UDPSocket.new


def send_msg(sock, msg)
	data = msg
	sock.send(data, 0, '127.0.0.1', 33333)
end

	key = 'secret'


loop  do
	msg = gets.chomp.to_s

	cipher = msg.encrypt(key) 
	enc   = Base64.encode64(cipher)

	send_msg(sock, enc)
	puts enc
end

sock.close

