require_relative 'board'
require_relative 'game'
require_relative 'player'
require_relative 'ui'

current_game = Game.new(Board.new, Player.new('X'), Player.new('O'), UI.new)
current_game.play_game
