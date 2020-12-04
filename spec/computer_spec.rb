require 'board'
require 'game'
require 'computer'
require 'referee'


describe Computer do
  let(:computer) { Computer.new('O', Referee.new) }
  let(:board) { Board.new }
  let(:referee) { Referee.new }
  let(:ui) { UI.new }

  def set_board_values(board, array_values)
    array_values.each_with_index do |val, index|
      board.set_token_at(index + 1, val)
    end
  end

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    set_board_values(board, %w(
      X X 3
      O 5 6
      7 8 9
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win" do
    set_board_values(board, %w(
      O O 3
      X 5 6
      X 8 9
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    set_board_values(board, %w(
      X 2 X
      O O 6
      7 8 X
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    set_board_values(board, %w(
      X 2 3
      4 5 6
      7 O X
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(5)).to eq 'O'
  end

  it "blocks column win from human" do
    set_board_values(board, %w(
      1 2 3
      4 5 X
      7 O X
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "finishes the game" do
    set_board_values(board, %w(
      O X X
      X X O
      7 O X
    ))

    expect{ computer.did_move?(board, ui) }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(board.get_token_at(7)).to eq 'O'
  end
end
