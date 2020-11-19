require 'human.rb'
require 'board.rb'

describe Human do
  let(:human) { Human.new('X') }

  it "has an enemy token" do
    expect(human.enemy_token).to eq('O')
  end

  it "sets player token in board" do
    board = Board.new
    expect(board.get_token_at(1)).to eq('1')
    human.make_move(board, 1)
    expect(board.get_token_at(1)).to eq('X')
  end
end
