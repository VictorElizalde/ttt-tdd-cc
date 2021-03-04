$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'game'
require 'computer'
require 'human'
require 'referee'
require 'ui'
require 'terminal_input'
require 'browser_input'
require 'curler'
require 'file_handler'

referee = Referee.new

current_game = Game.new(Board.new, UI.new, referee, [Human.new('X', TerminalInput.new, BrowserInput.new), Computer.new('O', referee)], nil, Curler.new, FileHandler.new)
current_game.play_game
