require 'ui.rb'
require 'board.rb'

describe "UI" do
  let(:ui) { UI.new }

  it "prints empty board with 1 to 9 coordinates" do
    board = Board.new
    expect(ui.print(board)).to eq(<<-EOS
        [1,2,3]
        [4,5,6]
        [7,8,9]
      EOS
    )
  end

  it "prints board with player marks" do
    board = Board.new
    board.put_token_in_board([5, -1], "X")
    board.put_token_in_board([9, -1], "O")
    expect(ui.print(board)).to eq(<<-EOS
        [1,2,3]
        [4,X,6]
        [7,8,O]
      EOS
    )
  end

  it "prints user instruction for token location" do
    expect { ui.prints_user_instructions }.to output("Select coordinate between 1 and 9\n").to_stdout
  end

  it "sets token in user input coordinate" do
    board = Board.new
    user_input1 = '1'
    user_input2 = '1'
    expect(ui.receive_token_coordinate(user_input1, user_input2)).to eq([1, 1])
    expect(board.get_token_at(1)).to eq('1')
    board.put_token_in_board(ui.receive_token_coordinate(user_input1, user_input2), 'X')
    expect(board.get_token_at(5)).to eq('X')
  end
end
