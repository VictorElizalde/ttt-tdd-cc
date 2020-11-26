$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'game'
require 'player'
require 'computer'
require 'human'
require 'referee'
require 'ui'

current_game = Game.new(Board.new, Human.new('X'), Computer.new('O'), UI.new, Referee.new)
current_game.play_game
