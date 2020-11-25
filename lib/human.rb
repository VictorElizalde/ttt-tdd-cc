$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'player'

class Human < Player
  def make_move(board, coordinates)
    set_user_token_at(board, coordinates, @token)
  end

  private
    def set_user_token_at(board, coordinates, mark)
      coor1, coor2 = coordinates.first, coordinates.last
      matrix_rows = board.get_tokens.each_slice(3).to_a
      game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]

      game_matrix[coor1, coor2] = mark

      game_array = []
      game_matrix.each do |token|
        game_array << token
      end

      game_array.each_with_index do |val, index|
        board.set_token_at(index + 1, val)
      end
    end
end
