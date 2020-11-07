class UI
  def display_board(rule)
    playing_board = ''
    playing_board << " #{rule.board[0]} | #{rule.board[1]} | #{rule.board[2]} "
    playing_board << "\n-----------\n"
    playing_board << " #{rule.board[3]} | #{rule.board[4]} | #{rule.board[5]}"
    playing_board << "\n-----------\n"
    playing_board << " #{rule.board[6]} | #{rule.board[7]} | #{rule.board[8]}"
    puts playing_board
    playing_board
  end

  def receive_token_location
    puts 'Select coordinate between 1 and 9'
    gets.chomp
  end
end
