require 'human'
require 'board'

describe Human do
  let(:human) { Human.new('X') }
  let(:board) { Board.new }

  def set_board_values(board, array_values)
    array_values.each_with_index do |val, index|
      board.set_token_at(index + 1, val)
    end
  end

  it "sets player token in board" do
    expect(board.get_token_at(1)).to eq('1')

    human.did_move?(board, [0,0])

    expect(board.get_token_at(1)).to eq('X')
  end

  it "receives user input coordinates correctly" do
    user_input1 = '1'
    user_input2 = '1'

    expect(human.receive_token_coordinate(user_input1, user_input2)).to eq([1, 1])
  end

  it "sets token in user input coordinate" do
    user_input1 = '1'
    user_input2 = '1'

    expect(human.receive_token_coordinate(user_input1, user_input2)).to eq([1, 1])
    expect(board.get_token_at(1)).to eq('1')

    human.did_move?(board, human.receive_token_coordinate(user_input1, user_input2))

    expect(board.get_token_at(5)).to eq('X')
  end

  it "returns true and performs the move" do
    set_board_values(board, %w(
      1 _ _
      _ _ _
      _ _ _
    ))
    expect(board.get_token_at(1)).to eq('1')

    expect(human.did_move?(board, [0,0])).to eq(true)
    expect(board.get_token_at(1)).to eq('X')
  end

  it "return false and doesn't perform the move" do
    set_board_values(board, %w(
      O _ _
      _ _ _
      _ _ _
    ))
    expect(board.get_token_at(1)).to eq('O')

    expect(human.did_move?(board, [0,0])).to eq(false)
    expect(board.get_token_at(1)).to eq('O')
  end
end
