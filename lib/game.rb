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
    @computer.make_move(@board, @referee)
  end

  def human_move_succesful?(coordinates)
    if @board.available_location?(coordinates)
      @human.make_move(@board, coordinates)
      return true
    else
      return false
    end
  end
end
