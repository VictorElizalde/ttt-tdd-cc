require 'player'

class Human < Player
  attr_reader :terminal_input, :browser_input

  def initialize(token, terminal_input, browser_input)
    super(token)
    @terminal_input = terminal_input
    @browser_input = browser_input
  end

  def did_move?(board, ui, input_type = nil, coordinates = nil)
    ui.print(board)
    ui.prints_user_instructions

    case input_type
    when "1"
      coordinates = receive_terminal_coordinates() if coordinates == nil
    when "2"
      coordinates = receive_browser_coordinates()
    end

    if available_location?(board, coordinates)
      set_user_token_at(board, coordinates, @token)
      return true
    else
      return false
    end
  end

  def receive_terminal_coordinates(user_input1 = nil, user_input2 = nil)
    @terminal_input.get_input(user_input1, user_input2)
  end

  def receive_browser_coordinates
    @browser_input.get_input
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
