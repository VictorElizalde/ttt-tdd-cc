require 'ui'
require 'board'

describe "UI" do
  let(:ui) { UI.new }
  let(:board) { Board.new }
  let(:human) { Human.new('X') }

  it "prints empty board with 1 to 9 coordinates" do
    expect{ ui.print(board) }.to output(<<-EOS
        [1,2,3]
        [4,5,6]
        [7,8,9]
      EOS
    ).to_stdout
  end

  it "prints board with player marks" do
    board.set_token_at(5, "X")
    board.set_token_at(9, "O")

    expect{ ui.print(board) }.to output(<<-EOS
        [1,2,3]
        [4,X,6]
        [7,8,O]
      EOS
    ).to_stdout
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

  it "prints tie" do
    expect{ ui.print_tie }.to output(<<-EOS
        Tie!
      EOS
    ).to_stdout
  end

  it "prints game winner and the token" do
    expect{ ui.print_winner('X') }.to output(<<-EOS
        Winner is X!
      EOS
    ).to_stdout
  end

  it "prints computer's turn" do
    expect{ ui.print_computer_turn }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout
  end
end
