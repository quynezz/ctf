require 'socket'

ports = [1111, 2222, 3333, 4444]

ports.each do |port|
  puts "[+] Port: #{port}"
  sleep 1
  begin
    s = TCPSocket.new '10.49.167.36', port
    s.close
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    next
  end
end
