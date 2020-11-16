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

  def get_token_at(pos)
    @tokens[pos - 1]
  end

  def put_token_in_board(data_translator, pos, coordinates, mark)
    if coordinates == nil
      set_token_at(pos, mark)
    else
      set_user_token_at(data_translator, coordinates, mark)
    end
  end

  def reset_token_at(pos)
    @tokens[pos - 1] = pos.to_s
  end

  def rows(data_translator)
    data_translator.get_tokens(@tokens).each_slice(3).to_a
  end

  def columns(data_translator)
    rows(data_translator).transpose
  end

  def diagonals
    [[@tokens[0], @tokens[4], @tokens[8]], [@tokens[2], @tokens[4], @tokens[6]]]
  end

  private
    def set_token_at(pos, mark)
      @tokens[pos - 1] = mark
    end

    def set_user_token_at(data_translator, coordinates, mark)
      coor1, coor2 = coordinates.first, coordinates.last
      matrix_rows = data_translator.get_tokens(@tokens).each_slice(3).to_a
      game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]
      keys = [0,1,2,3,4,5,6,7,8]

      game_matrix[coor1, coor2] = mark

      game_array = []
      game_matrix.each do |token|
        game_array << token
      end

      @tokens = keys.zip(game_array).to_h
    end
end
