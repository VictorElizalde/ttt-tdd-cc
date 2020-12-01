$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'human'
require 'board'

describe Human do
  let(:human) { Human.new('X') }
  let(:board) { Board.new }

  it "sets player token in board" do
    user_input1 = '0'
    user_input2 = '0'

    expect(board.get_token_at(1)).to eq('1')

    human.make_move?(board, human.receive_token_coordinate(user_input1, user_input2))

    expect(board.get_token_at(1)).to eq('X')
  end

  it "sets token in user input coordinate" do
    user_input1 = '1'
    user_input2 = '1'

    expect(human.receive_token_coordinate(user_input1, user_input2)).to eq([1, 1])
    expect(board.get_token_at(1)).to eq('1')

    human.make_move?(board, human.receive_token_coordinate(user_input1, user_input2))

    expect(board.get_token_at(5)).to eq('X')
  end
end
