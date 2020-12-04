require 'board'
require 'computer'
require 'human'
require 'ui'


class Game
  attr_accessor :board, :ui, :referee, :players

  def initialize(board, ui, referee, players_array)
    @board = board
    @ui = ui
    @referee = referee
    @players = players_array
  end

  def play_game
    run_turns
    print_results
  end

  def print_results
    @referee.evaluate_game(@board, @ui)
  end

  def run_turns
    i = 0
    until @referee.game_over?(@board) || @referee.winner?(@board)
      if i == @players.size
        i = 0
      end

      player_on_turn = @players[i]

      until player_on_turn.did_move?(@board, @ui)
        @ui.prints_invalid_move
      end

      i += 1
    end

    @ui.print(board)
  end
end
