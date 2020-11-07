class Board
  attr_accessor :board

  def initialize
    @board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  end

  def set_token_at(coordinate, token)
    board[coordinate - 1] = token
  end
end
