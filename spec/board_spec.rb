require 'board.rb'
require 'game.rb'

describe "Board" do
  let(:board) { Board.new }
  let(:game) { Game.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(game, 7)).to eq('7')
    board.set_token_at(game, 7, 'X')
    expect(board.get_token_at(game, 7)).to eq('X')
  end

  it "resets token at occupied coordinate" do
    board.set_token_at(game, 7, 'X')
    expect(board.get_token_at(game, 7)).to eq('X')
    board.reset_token_at(game, 7)
    expect(board.get_token_at(game, 7)).to eq('7')
  end
end
