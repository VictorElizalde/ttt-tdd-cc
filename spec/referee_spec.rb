require 'referee.rb'
require 'board.rb'
require 'game.rb'
require 'data_translator.rb'

describe "Referee" do
  let(:referee) { Referee.new }
  let(:board) { Board.new }
  let(:data_translator) { DataTranslator.new }

  it "returns horizontal winner" do
    game = Game.new
    board.set_token_at(game, 1, 'X')
    board.set_token_at(game, 2, 'X')
    board.set_token_at(game, 3, 'X')
    expect(referee.winner?(data_translator, game)).to eq(true)
  end

  it "returns vertical winner" do
    game1 = Game.new
    board.set_token_at(game1, 1, 'X')
    board.set_token_at(game1, 4, 'X')
    board.set_token_at(game1, 7, 'X')
    expect(referee.winner?(data_translator, game1)).to eq(true)
  end

  it "returns diagonal winner" do
    game2 = Game.new
    board.set_token_at(game2, 1, 'X')
    board.set_token_at(game2, 5, 'X')
    board.set_token_at(game2, 9, 'X')
    expect(referee.winner?(data_translator, game2)).to eq(true)
  end

  it "returns true if tie exists" do
    game = Game.new
    game.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => 'O', 7 => 'O', 8 => 'X'
                  }
    expect(referee.tie?(data_translator, game)).to eq(true)
  end

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      game = Game.new
      game.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(data_translator, game)).to eq(false)

      board.set_token_at(game, 9, 'X')
      expect(referee.game_over?(data_translator, game)).to eq(true)
      expect(referee.winner?(data_translator, game)).to eq(false)
    end

    it "returns true if there's a winner" do
      game = Game.new
      game.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(data_translator, game)).to eq(false)

      board.set_token_at(game, 1, 'X')
      expect(referee.game_over?(data_translator, game)).to eq(true)
      expect(referee.winner?(data_translator, game)).to eq(true)
    end
  end

  describe "#winner_token" do
    it "returns 'X' as row winner token" do
      game = Game.new
      game.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      board.set_token_at(game, 1, 'X')
      expect(referee.game_over?(data_translator, game)).to eq(true)
      expect(referee.winner?(data_translator, game)).to eq(true)
      expect(referee.winner_token(data_translator, game)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      game = Game.new
      game.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'O',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'X', 7 => 'O', 8 => '9'
                    }
      board.set_token_at(game, 9, 'O')
      expect(referee.game_over?(data_translator, game)).to eq(true)
      expect(referee.winner?(data_translator, game)).to eq(true)
      expect(referee.winner_token(data_translator, game)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      game = Game.new
      game.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => 'X'
                    }
      board.set_token_at(game, 1, 'X')
      expect(referee.game_over?(data_translator, game)).to eq(true)
      expect(referee.winner?(data_translator, game)).to eq(true)
      expect(referee.winner_token(data_translator, game)).to eq('X')
    end
  end
end
