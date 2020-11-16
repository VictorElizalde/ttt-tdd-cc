require 'referee.rb'
require 'board.rb'
require 'data_translator.rb'

describe "Referee" do
  let(:referee) { Referee.new }
  let(:data_translator) { DataTranslator.new }

  it "returns horizontal winner" do
    board = Board.new
    board.put_token_in_board(data_translator, 1, nil, 'X')
    board.put_token_in_board(data_translator, 2, nil, 'X')
    board.put_token_in_board(data_translator, 3, nil, 'X')
    expect(referee.winner?(data_translator, board)).to eq(true)
  end

  it "returns vertical winner" do
    board1 = Board.new
    board1.put_token_in_board(data_translator, 1, nil, 'X')
    board1.put_token_in_board(data_translator, 4, nil, 'X')
    board1.put_token_in_board(data_translator, 7, nil, 'X')
    expect(referee.winner?(data_translator, board1)).to eq(true)
  end

  it "returns diagonal winner" do
    board2 = Board.new
    board2.put_token_in_board(data_translator, 1, nil, 'X')
    board2.put_token_in_board(data_translator, 5, nil, 'X')
    board2.put_token_in_board(data_translator, 9, nil, 'X')
    expect(referee.winner?(data_translator, board2)).to eq(true)
  end

  it "returns true if tie exists" do
    board = Board.new
    board.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => 'O', 7 => 'O', 8 => 'X'
                  }
    expect(referee.tie?(data_translator, board)).to eq(true)
  end

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      board = Board.new
      board.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(data_translator, board)).to eq(false)

      board.put_token_in_board(data_translator, 9, nil, 'X')
      expect(referee.game_over?(data_translator, board)).to eq(true)
      expect(referee.winner?(data_translator, board)).to eq(false)
    end

    it "returns true if there's a winner" do
      board = Board.new
      board.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(data_translator, board)).to eq(false)

      board.put_token_in_board(data_translator, 1, nil, 'X')
      expect(referee.game_over?(data_translator, board)).to eq(true)
      expect(referee.winner?(data_translator, board)).to eq(true)
    end
  end

  describe "#winner_token" do
    it "returns 'X' as row winner token" do
      board = Board.new
      board.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      board.put_token_in_board(data_translator, 1, nil, 'X')
      expect(referee.game_over?(data_translator, board)).to eq(true)
      expect(referee.winner?(data_translator, board)).to eq(true)
      expect(referee.winner_token(data_translator, board)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      board = Board.new
      board.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'O',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'X', 7 => 'O', 8 => '9'
                    }
      board.put_token_in_board(data_translator, 9, nil, 'O')
      expect(referee.game_over?(data_translator, board)).to eq(true)
      expect(referee.winner?(data_translator, board)).to eq(true)
      expect(referee.winner_token(data_translator, board)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      board = Board.new
      board.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => 'X'
                    }
      board.put_token_in_board(data_translator, 1, nil, 'X')
      expect(referee.game_over?(data_translator, board)).to eq(true)
      expect(referee.winner?(data_translator, board)).to eq(true)
      expect(referee.winner_token(data_translator, board)).to eq('X')
    end
  end
end
