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

    begin
    cipher.update(s) + cipher.final
	rescue
		puts "Wrong Encripty key"
	end
  end
end


BasicSocket.do_not_reverse_lookup = true
client = UDPSocket.new
client.bind('0.0.0.0', 33333)


	key = 'secret1'
loop do
	data, addr = client.recvfrom(1024)

	plain = Base64.decode64(data)
	puts plain

	msg = plain.decrypt(key)

	puts msg
	

end

client.close



