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

  def play_game
    run_turns
    print_results
  end

  def print_results
    puts evaluate_game
  end

  def run_turns
    until @referee.game_over?(@board) || @referee.winner?(@board)
      if @human_turn
        
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

  def evaluate_game
    @referee.tie?(@board) ? "Tie!" : "Winner is #{@referee.winner_token(@board)}!"
  end

  def computer_move
    @computer.make_move(@board, @referee)
  end

  def human_move_succesful?(coordinates = nil)
    return @human.make_move?(@board, coordinates)
  end
end
