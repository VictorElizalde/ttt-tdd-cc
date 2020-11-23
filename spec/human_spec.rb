require File.join(File.dirname(__FILE__), '..', 'lib', 'human')
require File.join(File.dirname(__FILE__), '..', 'lib', 'board')
require File.join(File.dirname(__FILE__), '..', 'lib', 'ui')

describe Human do
  let(:human) { Human.new('X') }
  let(:ui) { UI.new }
  let(:board) { Board.new }

  it "sets player token in board" do
    user_input1 = '0'
    user_input2 = '0'

    expect(board.get_token_at(1)).to eq('1')

    human.make_move(board, ui.receive_token_coordinate(user_input1, user_input2))

    expect(board.get_token_at(1)).to eq('X')
  end
end
