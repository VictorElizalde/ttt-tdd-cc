require 'computer.rb'
require 'game.rb'
require 'board.rb'

describe Computer do
  let(:computer) { Computer.new('O') }
  let(:data_translator) { DataTranslator.new }

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board(data_translator, 1, nil, 'X')
    board.put_token_in_board(data_translator, 4, nil, 'O')
    board.put_token_in_board(data_translator, 2, nil, 'X')
    computer.make_move(data_translator, board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board(data_translator, 1, nil, 'O')
    board.put_token_in_board(data_translator, 4, nil, 'X')
    board.put_token_in_board(data_translator, 2, nil, 'O')
    board.put_token_in_board(data_translator, 7, nil, 'X')
    computer.make_move(data_translator, board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board(data_translator, 1, nil, 'X')
    board.put_token_in_board(data_translator, 4, nil, 'O')
    board.put_token_in_board(data_translator, 9, nil, 'X')
    board.put_token_in_board(data_translator, 5, nil, 'O')
    board.put_token_in_board(data_translator, 3, nil, 'X')
    computer.make_move(data_translator, board, referee)

    expect(board.get_token_at(6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board(data_translator, 9, nil, 'X')
    board.put_token_in_board(data_translator, 8, nil, 'O')
    board.put_token_in_board(data_translator, 1, nil, 'X')
    computer.make_move(data_translator, board, referee)

    expect(board.get_token_at(5)).to eq 'O'
  end

  it "blocks column win from human" do
    board = Board.new
    referee = Referee.new
    board.put_token_in_board(data_translator, 9, nil, 'X')
    board.put_token_in_board(data_translator, 8, nil, 'O')
    board.put_token_in_board(data_translator, 6, nil, 'X')
    computer.make_move(data_translator, board, referee)

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
    computer.make_move(data_translator, board, referee)
    expect(board.get_token_at(7)).to eq 'O'
  end
end
