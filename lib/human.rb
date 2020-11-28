$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'player'

class Human < Player
  def make_move?(board, coordinates)
    if available_location?(board, coordinates)
      set_user_token_at(board, coordinates, @token)
      return true
    else
      return false
    end
  end

  private
    def set_user_token_at(board, coordinates, mark)
      coor1, coor2 = coordinates.first, coordinates.last
      board_info = board.get_board_info

      board_info[coor1, coor2] = mark

      unparsed_board_info = []
      board_info.each do |token|
        unparsed_board_info << token
      end

      board.parse_board(unparsed_board_info)
    end

    def available_location?(board, coordinates)
      coor1, coor2 = coordinates.first, coordinates.last
      board_info = board.get_board_info

      return board_info[coor1, coor2] != 'X' && board_info[coor1, coor2] != 'O'
    end
end
