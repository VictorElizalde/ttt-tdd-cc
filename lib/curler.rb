require 'launchy'
require 'net/http'
require 'uri'

class Curler
  def request_html_to_server(board_tokens)
    uri = URI.parse("http://localhost:5000/ttt")
    request = Net::HTTP::Get.new(uri)
    request.body = board_tokens

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    response
  end

  def update_browser_view
    dirname = Dir.getwd
    dirname = "file://" + dirname +  "/ttt_board.html"
    Launchy.open( dirname )
  end
end