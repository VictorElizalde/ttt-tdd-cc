require_relative 'player'

class Human < Player
  def make_move(game, board, coordinate)
    board.set_token_at(game, coordinate, @token)
  end
end
