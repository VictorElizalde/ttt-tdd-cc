require 'board.rb'

describe "Board" do
  let(:board) { Board.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(7)).to eq('7')
    board.put_token_in_board([7, -1], 'X')
    expect(board.get_token_at(7)).to eq('X')
  end

  it "resets token at occupied coordinate" do
    board.put_token_in_board([7, -1], 'X')
    expect(board.get_token_at(7)).to eq('X')
    board.reset_token_at(7)
    expect(board.get_token_at(7)).to eq('7')
  end
end
