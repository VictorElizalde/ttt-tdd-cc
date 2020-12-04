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

  def play_game
    run_turns
    print_results
  end

  def print_results
    @referee.evaluate_game(@board, @ui)
  end

  def run_turns(coordinates = nil)
    until @referee.game_over?(@board) || @referee.winner?(@board)
      if @human_turn
        human_move(coordinates)
      else
        computer_move
      end

      change_turn
    end

    @ui.print(board)
  end

  def change_turn
    @human_turn = !@human_turn
  end

  def computer_move
    @ui.print_computer_turn
    @computer.make_move(@board, @referee)
  end

  def human_move_succesful?(coordinates = nil)
    return @human.did_move?(@board, coordinates)
  end

  def human_move(coordinates = nil)
    @ui.print(board)
    @ui.prints_user_instructions

    until human_move_succesful?(coordinates)
      @ui.prints_invalid_move
    end
  end
end
