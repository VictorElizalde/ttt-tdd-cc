require 'computer.rb'
require 'game.rb'
require 'board.rb'

describe Computer do
  let(:computer) { Computer.new('O') }

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board([1, -1], 'X')
    board.put_token_in_board([4, -1], 'O')
    board.put_token_in_board([2, -1], 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board([1, -1], 'O')
    board.put_token_in_board([4, -1], 'X')
    board.put_token_in_board([2, -1], 'O')
    board.put_token_in_board([7, -1], 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board([1, -1], 'X')
    board.put_token_in_board([4, -1], 'O')
    board.put_token_in_board([9, -1], 'X')
    board.put_token_in_board([5, -1], 'O')
    board.put_token_in_board([3, -1], 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board([9, -1], 'X')
    board.put_token_in_board([8, -1], 'O')
    board.put_token_in_board([1, -1], 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(5)).to eq 'O'
  end

  it "blocks column win from human" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board([9, -1], 'X')
    board.put_token_in_board([8, -1], 'O')
    board.put_token_in_board([6, -1], 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "finishes the game" do
    board = Board.new
    referee = Referee.new
    board.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => '7', 7 => 'O', 8 => 'X'
                  }
    computer.make_move(board, referee)
    expect(board.get_token_at(7)).to eq 'O'
  end
end
