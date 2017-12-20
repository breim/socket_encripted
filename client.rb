require 'socket'
require 'openssl'
require "base64"


class String
  def encrypt(key)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').encrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = cipher.update(self) + cipher.final
    
    s.unpack('H*')[0].upcase
  end

  def decrypt(key)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').decrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = [self].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end
end

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

