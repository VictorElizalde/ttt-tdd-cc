require File.join(File.dirname(__FILE__), '..', 'lib', 'computer')
require File.join(File.dirname(__FILE__), '..', 'lib', 'game')
require File.join(File.dirname(__FILE__), '..', 'lib', 'board')


describe Computer do
  let(:computer) { Computer.new('O') }
  let(:board) { Board.new }
  let(:referee) { Referee.new }

  def set_board_values(board, hash_values)
    board.tokens = hash_values
  end

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    set_board_values(board, {
      0 => 'X', 1 => 'X', 2 => '3',
      3 => 'O', 4 => '5', 5 => '6',
      6 => '7', 7 => '8', 8 => '9'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win" do
    set_board_values(board, {
      0 => 'O', 1 => 'O', 2 => '3',
      3 => 'X', 4 => '5', 5 => '6',
      6 => 'X', 7 => '8', 8 => '9'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    set_board_values(board, {
      0 => 'X', 1 => '2', 2 => 'X',
      3 => 'O', 4 => 'O', 5 => '6',
      6 => '7', 7 => '8', 8 => 'X'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    set_board_values(board, {
      0 => 'X', 1 => '2', 2 => '3',
      3 => '4', 4 => '5', 5 => '6',
      6 => '7', 7 => 'O', 8 => 'X'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(5)).to eq 'O'
  end

  it "blocks column win from human" do
    set_board_values(board, {
      0 => '1', 1 => '2', 2 => '3',
      3 => '4', 4 => '5', 5 => 'X',
      6 => '7', 7 => 'O', 8 => 'X'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "finishes the game" do
    set_board_values(board, {
      0 => 'O', 1 => 'X', 2 => 'X',
      3 => 'X', 4 => 'X', 5 => 'O',
      6 => '7', 7 => 'O', 8 => 'X'
    })

    computer.make_move(board, referee)

    expect(board.get_token_at(7)).to eq 'O'
  end
end
