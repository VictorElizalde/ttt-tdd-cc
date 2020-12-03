$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'ui'
require 'board'

describe "UI" do
  let(:ui) { UI.new }
  let(:board) { Board.new }
  let(:human) { Human.new('X') }

  it "prints empty board with 1 to 9 coordinates" do
    expect(ui.print(board)).to eq(<<-EOS
        [1,2,3]
        [4,5,6]
        [7,8,9]
      EOS
    )
  end

  it "prints board with player marks" do
    board.set_token_at(5, "X")
    board.set_token_at(9, "O")

    expect(ui.print(board)).to eq(<<-EOS
        [1,2,3]
        [4,X,6]
        [7,8,O]
      EOS
    )
  end

  it "prints user instruction for token location" do
    expect { ui.prints_user_instructions }.to output(<<-EOS
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout
  end

  it "prints user indicator that move was invalid" do
    expect{ ui.prints_invalid_move }.to output(<<-EOS
        Invalid move, try again
      EOS
    ).to_stdout
  end
end
