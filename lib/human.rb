$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'player'

class Human < Player
  def make_move?(board, coordinates = nil)
    if coordinates == nil
      coordinates = receive_token_coordinate()
    end

    if available_location?(board, coordinates)
      set_user_token_at(board, coordinates, @token)
      return true
    else
      return false
    end
  end

  def receive_token_coordinate(user_input1 = nil, user_input2 = nil, stdin: $stdin)
    user_input1 = stdin.gets.chomp if user_input1.nil?
    user_input2 = stdin.gets.chomp if user_input2.nil?
    [user_input1.to_i, user_input2.to_i]
  end

  private
    def set_user_token_at(board, coordinates, mark)
      coor1, coor2 = coordinates.first, coordinates.last
      board_info = convert_to_matrix(board)

      board_info[coor1, coor2] = mark

      unparsed_board_info = []
      board_info.each do |token|
        unparsed_board_info << token
      end

      board.parse_board(unparsed_board_info)
    end

    def available_location?(board, coordinates)
      coor1, coor2 = coordinates.first, coordinates.last
      board_info = convert_to_matrix(board)

      return board_info[coor1, coor2] != 'X' && board_info[coor1, coor2] != 'O'
    end

    def convert_to_matrix(board)
      matrix_rows = board.rows
      game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]
    end
end
