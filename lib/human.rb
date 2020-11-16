require_relative 'player'

class Human < Player
  def make_move(data_translator, board, coordinate)
    board.put_token_in_board(data_translator, coordinate, nil, @token)
  end
end
