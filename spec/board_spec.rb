require 'board.rb'
require 'data_translator.rb'

describe "Board" do
  let(:board) { Board.new }
  let(:data_translator) { DataTranslator.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(7)).to eq('7')
    board.put_token_in_board(data_translator, 7, nil, 'X')
    expect(board.get_token_at(7)).to eq('X')
  end

  it "resets token at occupied coordinate" do
    board.put_token_in_board(data_translator, 7, nil, 'X')
    expect(board.get_token_at(7)).to eq('X')
    board.reset_token_at(7)
    expect(board.get_token_at(7)).to eq('7')
  end
end
