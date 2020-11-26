require 'matrix'

class Board
  attr_accessor :tokens

  def initialize
    @tokens = {
      0 => '1', 1 => '2', 2 => '3',
      3 => '4', 4 => '5', 5 => '6',
      6 => '7', 7 => '8', 8 => '9'
    }
  end

  def get_tokens
    @tokens.values
  end

  def get_token_at(pos)
    @tokens[pos - 1]
  end

  def set_token_at(pos, mark)
    @tokens[pos - 1] = mark
  end

  def reset_token_at(pos)
    @tokens[pos - 1] = pos.to_s
  end

  def rows
    get_tokens.each_slice(3).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [[@tokens[0], @tokens[4], @tokens[8]], [@tokens[2], @tokens[4], @tokens[6]]]
  end

  def available_location?(coordinates)
    coor1, coor2 = coordinates.first, coordinates.last
    game_matrix = get_matrix

    return game_matrix[coor1, coor2] != 'X' && game_matrix[coor1, coor2] != 'O'
  end

  def get_matrix
    matrix_rows = get_tokens.each_slice(3).to_a
    game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]
  end

  def set_matrix_to_hash(game_array)
    game_array.each_with_index do |val, index|
      set_token_at(index + 1, val)
    end
  end
end
