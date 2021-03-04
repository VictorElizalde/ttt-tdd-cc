require 'human'
require 'board'
require 'ui'
require 'terminal_input'
require 'browser_input'

describe Human do
  let(:human) { Human.new('X', TerminalInput.new, BrowserInput.new) }
  let(:board) { Board.new }
  let(:ui) { UI.new }

  def set_board_values(board, array_values)
    array_values.each_with_index do |val, index|
      board.set_token_at(index + 1, val)
    end
  end

  it "sets player token in board" do
    expect(board.get_token_at(1)).to eq('1')

    expect{ human.did_move?(board, ui, "1", [0,0]) }.to output(<<-EOS 
        [1,2,3]
        [4,5,6]
        [7,8,9]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout

    expect(board.get_token_at(1)).to eq('X')
  end

  it "receives user input coordinates correctly" do
    user_input1 = '1'
    user_input2 = '1'

    expect(human.receive_terminal_coordinates(user_input1, user_input2)).to eq([1, 1])
  end

  it "sets token in user input coordinate" do
    user_input1 = '1'
    user_input2 = '1'

    expect(human.receive_terminal_coordinates(user_input1, user_input2)).to eq([1, 1])
    expect(board.get_token_at(1)).to eq('1')

    expect{ human.did_move?(board, ui, "1", human.receive_terminal_coordinates(user_input1, user_input2)) }.to output(<<-EOS 
        [1,2,3]
        [4,5,6]
        [7,8,9]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout

    expect(board.get_token_at(5)).to eq('X')
  end

  it "returns true and performs the move" do
    set_board_values(board, %w(
      1 _ _
      _ _ _
      _ _ _
    ))
    expect(board.get_token_at(1)).to eq('1')

    expect{ human.did_move?(board, ui, "1", [0,0]) }.to output(<<-EOS 
        [1,_,_]
        [_,_,_]
        [_,_,_]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout
    expect(board.get_token_at(1)).to eq('X')
  end

  it "return false and doesn't perform the move" do
    set_board_values(board, %w(
      O _ _
      _ _ _
      _ _ _
    ))
    expect(board.get_token_at(1)).to eq('O')

    expect{ human.did_move?(board, ui, "1", [0,0]) }.to output(<<-EOS 
        [O,_,_]
        [_,_,_]
        [_,_,_]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout
    expect(board.get_token_at(1)).to eq('O')
  end

  it "does not put the token because location is already taken" do
    user_input1 = 0
    user_input2 = 0
    set_board_values(board, %w(
      O _ _
      _ _ _
      _ _ _
    ))

    expect(board.get_token_at(1)).to eq('O')

    expect{ human.did_move?(board, ui, "1", human.receive_terminal_coordinates(user_input1, user_input2)) }.to output(<<-EOS 
        [O,_,_]
        [_,_,_]
        [_,_,_]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout

    expect(board.get_token_at(1)).to eq('O')
  end
end
