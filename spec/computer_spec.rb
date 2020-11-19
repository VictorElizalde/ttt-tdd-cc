require 'computer.rb'
require 'game.rb'
require 'board.rb'

describe Computer do
  let(:computer) { Computer.new('O') }
  let(:board) { Board.new }
  let(:referee) { Referee.new }

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    board.set_token_at(1, 'X')
    board.set_token_at(4, 'O')
    board.set_token_at(2, 'X')

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win" do
    board.set_token_at(1, 'O')
    board.set_token_at(4, 'X')
    board.set_token_at(2, 'O')
    board.set_token_at(7, 'X')

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    board.set_token_at(1, 'X')
    board.set_token_at(4, 'O')
    board.set_token_at(9, 'X')
    board.set_token_at(5, 'O')
    board.set_token_at(3, 'X')

    computer.make_move(board, referee)

    expect(board.get_token_at(6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    board.set_token_at(9, 'X')
    board.set_token_at(8, 'O')
    board.set_token_at(1, 'X')

    computer.make_move(board, referee)

    expect(board.get_token_at(5)).to eq 'O'
  end

  it "blocks column win from human" do
    board.set_token_at(9, 'X')
    board.set_token_at(8, 'O')
    board.set_token_at(6, 'X')

    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "finishes the game" do
    board.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => '7', 7 => 'O', 8 => 'X'
                  }

    computer.make_move(board, referee)

    expect(board.get_token_at(7)).to eq 'O'
  end
end
