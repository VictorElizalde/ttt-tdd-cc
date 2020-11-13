class Game
  attr_accessor :tokens

  def initialize()
    @tokens = {
      0 => '1', 1 => '2', 2 => '3',
      3 => '4', 4 => '5', 5 => '6',
      6 => '7', 7 => '8', 8 => '9'
    }
  end
end
