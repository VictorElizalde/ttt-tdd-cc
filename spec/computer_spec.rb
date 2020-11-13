require 'computer.rb'
require 'game.rb'
require 'board.rb'

describe Computer do
  let(:computer) { Computer.new('O') }
  let(:board) { Board.new }
  let(:data_translator) { DataTranslator.new }

  it "has an enemy token" do
    expect(computer.enemy_token).to eq('X')
  end

  it "blocks human win" do
    game = Game.new
    referee = Referee.new
    board.set_token_at(game, 1, 'X')
    board.set_token_at(game, 4, 'O')
    board.set_token_at(game, 2, 'X')
    computer.make_move(data_translator, game, board, referee)

    expect(board.get_token_at(game, 3)).to eq 'O'
  end

  it "takes the win" do
    game = Game.new
    referee = Referee.new
    board.set_token_at(game, 1, 'O')
    board.set_token_at(game, 4, 'X')
    board.set_token_at(game, 2, 'O')
    board.set_token_at(game, 7, 'X')
    computer.make_move(data_translator, game, board, referee)

    expect(board.get_token_at(game, 3)).to eq 'O'
  end

  it "takes the win instead of blocking" do
    game = Game.new
    referee = Referee.new
    board.set_token_at(game, 1, 'X')
    board.set_token_at(game, 4, 'O')
    board.set_token_at(game, 9, 'X')
    board.set_token_at(game, 5, 'O')
    board.set_token_at(game, 3, 'X')
    computer.make_move(data_translator, game, board, referee)

    expect(board.get_token_at(game, 6)).to eq 'O'
  end

  it "blocks diagonal win from human" do
    game = Game.new
    referee = Referee.new
    board.set_token_at(game, 9, 'X')
    board.set_token_at(game, 8, 'O')
    board.set_token_at(game, 1, 'X')
    computer.make_move(data_translator, game, board, referee)

    expect(board.get_token_at(game, 5)).to eq 'O'
  end

  it "blocks column win from human" do
    game = Game.new
    referee = Referee.new
    board.set_token_at(game, 9, 'X')
    board.set_token_at(game, 8, 'O')
    board.set_token_at(game, 6, 'X')
    computer.make_move(data_translator, game, board, referee)

    expect(board.get_token_at(game, 3)).to eq 'O'
  end

  it "finishes the game" do
    game = Game.new
    referee = Referee.new
    game.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => '7', 7 => 'O', 8 => 'X'
                  }
    computer.make_move(data_translator, game, board, referee)
    expect(board.get_token_at(game, 7)).to eq 'O'
  end
end
