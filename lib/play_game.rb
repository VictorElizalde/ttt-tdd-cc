$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'game'
require 'computer'
require 'human'
require 'referee'
require 'ui'

referee = Referee.new

current_game = Game.new(Board.new, UI.new, referee, [Human.new('X'), Computer.new('O', referee)])
current_game.play_game
