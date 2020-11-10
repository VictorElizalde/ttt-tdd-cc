class Board
  attr_accessor :tokens

  def initialize
    self.tokens = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def get_token_at(pos)
    tokens[pos - 1]
  end

  def set_token_at(pos, mark)
    tokens[pos - 1] = mark
  end
end
