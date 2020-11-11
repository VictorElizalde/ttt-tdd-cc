class Board
  def get_token_at(game, pos)
    game.tokens[pos - 1]
  end

  def set_token_at(game, pos, mark)
    game.tokens[pos - 1] = mark
  end

  def reset_token_at(game, pos)
    game.tokens[pos - 1] = pos.to_s
  end
end
