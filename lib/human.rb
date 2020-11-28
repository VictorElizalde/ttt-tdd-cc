$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'player'

class Human < Player
  def make_move(board, coordinates)
    set_user_token_at(board, coordinates, @token)
  end

  private
    def set_user_token_at(board, coordinates, mark)
      coor1, coor2 = coordinates.first, coordinates.last
      game_matrix = board.get_matrix

      game_matrix[coor1, coor2] = mark

      game_array = []
      game_matrix.each do |token|
        game_array << token
      end

      board.set_matrix_to_hash(game_array)
    end
end
