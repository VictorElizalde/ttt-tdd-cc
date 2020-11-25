require File.join(File.dirname(__FILE__), 'board')
require File.join(File.dirname(__FILE__), 'game')
require File.join(File.dirname(__FILE__), 'player')
require File.join(File.dirname(__FILE__), 'computer')
require File.join(File.dirname(__FILE__), 'human')
require File.join(File.dirname(__FILE__), 'referee')
require File.join(File.dirname(__FILE__), 'ui')


current_game = Game.new(Board.new, Human.new('X'), Computer.new('O'), UI.new, Referee.new)
current_game.play_game
