require_relative 'player'

class Human < Player
  def make_move(board, coordinate)
    board.set_token_at(coordinate, @token)
  end
end
