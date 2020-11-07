require 'game.rb'
require 'player.rb'
require 'ui.rb'
require 'board.rb'

describe Game do
  let(:game) { Game.new(Board.new, Player.new('X'), Player.new('O'), UI.new) }
  def fill_many(i, j, token)
    (i..j).each do |coordinate|
      game.board.set_token_at(coordinate, token)
    end
  end

  it "fills board with only X's" do
    fill_many(1, 9, 'X')
    expect(game.board.board).to eq(["X", "X", "X", "X", "X", "X", "X", "X", "X"])
  end

  it "fills board with only O's" do
    fill_many(1, 9, 'O')
    expect(game.board.board).to eq(["O", "O", "O", "O", "O", "O", "O", "O", "O"])
  end

  it "fills board with only X and O alternatively" do
    game.board.set_token_at(1, 'X')
    game.board.set_token_at(2, 'O')
    game.board.set_token_at(3, 'X')
    game.board.set_token_at(4, 'O')
    game.board.set_token_at(5, 'X')
    game.board.set_token_at(6, 'O')
    game.board.set_token_at(7, 'X')
    game.board.set_token_at(8, 'O')
    game.board.set_token_at(9, 'X')

    expect(game.board.board).to eq(["X", "O", "X", "O", "X", "O", "X", "O", "X"])
  end
end
