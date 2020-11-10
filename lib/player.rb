class Player
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def make_move(board, coordinate)
    board.set_token_at(coordinate, @token)
  end
end
