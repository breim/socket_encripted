require 'socket'
require_relative 'libs/encrypt.rb'


BasicSocket.do_not_reverse_lookup = true
client = UDPSocket.new
client.bind('0.0.0.0', 33333)


	key = 'secret'
loop do
	data, addr = client.recvfrom(1024)

	plain = Base64.decode64(data)
	puts plain

	msg = plain.decrypt(key)

	puts msg
	

end

client.close



