require File.join(File.dirname(__FILE__), '..', 'lib', 'board')

describe "Board" do
  let(:board) { Board.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(7)).to eq('7')

    board.set_token_at(7, 'X')

    expect(board.get_token_at(7)).to eq('X')
  end

  it "resets token at occupied coordinate" do
    board.set_token_at(7, 'X')

    expect(board.get_token_at(7)).to eq('X')

    board.reset_token_at(7)

    expect(board.get_token_at(7)).to eq('7')
  end
end
