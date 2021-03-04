class FileHandler
  def create_html_file_with_response(response)
    ttt_file = File.new('ttt_board.html', 'w')
    ttt_file.puts(response.body)
    ttt_file.close
  end
end