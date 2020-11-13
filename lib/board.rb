class Board
  def get_token_at(game, pos)
    game.tokens[pos - 1]
  end

  def set_token_at(game, pos, mark)
    game.tokens[pos - 1] = mark
  end

  def set_user_token_at(data_translator, game, coordinates, mark)
    coor1, coor2 = coordinates.first, coordinates.last
    matrix_rows = data_translator.get_tokens(game).each_slice(3).to_a
    game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]
    keys = [0,1,2,3,4,5,6,7,8]

    game_matrix[coor1, coor2] = mark

    game_array = []
    game_matrix.each do |token|
      game_array << token
    end

    game.tokens = keys.zip(game_array).to_h
  end

  def reset_token_at(game, pos)
    game.tokens[pos - 1] = pos.to_s
  end
end
