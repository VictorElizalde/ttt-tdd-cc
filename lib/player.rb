class Player
  attr_accessor :token, :enemy_token

  def initialize(token)
    @token = token
    @enemy_token = token == 'X' ? 'O' : 'X'
  end
end
