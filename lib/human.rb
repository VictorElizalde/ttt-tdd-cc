require_relative 'player'

class Human < Player
  def make_move(board, coordinate)
    board.put_token_in_board([coordinate, -1], @token)
  end
end
