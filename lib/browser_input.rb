require 'socket'

class BrowserInput
  def get_input
    coordinates = nil
    listener_client = nil
    listener_server = TCPServer.open(4000)

    loop do
      listener_client = listener_server.accept

      while (a = listener_client.gets) != "\r\n" do
        if a.include?("GET /move?coor=")
          coordinates = a.split("coor=")[1][0..2].split(",").map(&:to_i)
          puts coordinates
        end
      end

      unless coordinates == nil
        break
      end
    end

    listener_client.puts "HTTP/1.1 200 Success"
    listener_client.puts ""
    listener_client.puts "Success\n"
    listener_client.close

    coordinates
  end
end