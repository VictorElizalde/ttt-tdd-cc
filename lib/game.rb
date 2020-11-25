$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'computer'
require 'human'
require 'ui'


class Game
  attr_accessor :board, :human, :computer, :ui, :human_turn, :referee

  def initialize(board, human, computer, ui, referee)
    @board = board
    @computer = computer
    @human = human
    @human_turn = true
    @ui = ui
    @referee = referee
  end

  def change_turn
    @human_turn = !@human_turn
  end

  def evaluate_game
    @referee.tie?(@board) ? "Tie" : @referee.winner_token(@board)
  end

  def computer_move
    puts "Computer's turn"
    @computer.make_move(@board, @referee)
  end

  def human_move_succesful?(coordinates)
    if available_location?(coordinates)
      @human.make_move(@board, coordinates)
      return true
    else
      return false
    end
  end

  def available_location?(coordinates)
    coor1, coor2 = coordinates.first, coordinates.last
    matrix_rows = @board.get_tokens.each_slice(3).to_a
    game_matrix = Matrix[matrix_rows[0], matrix_rows[1], matrix_rows[2]]

    return game_matrix[coor1, coor2] != 'X' && game_matrix[coor1, coor2] != 'O'
  end
end
