# require_relative 'player'
# require_relative 'board'
# require_relative 'ui'
#
# class Game
#   attr_accessor :board, :player, :player_2, :ui
#
#   def initialize(board, player, player_2, ui)
#     @board = board
#     @player = player
#     @player_2 = player_2
#     @ui = ui
#   end
#
#   def play_game
#     turn = true
#     until @board.board.uniq == ['X', 'O'] || @board.board.uniq == ['X'] || @board.board.uniq == ['O']
#       @ui.display_board(@board)
#       move = @ui.receive_token_location
#       if turn
#         player.move(@board, move.to_i)
#       else
#         player_2.move(@board, move.to_i)
#       end
#       turn = !turn
#     end
#     @ui.display_board(@board)
#   end
# end
