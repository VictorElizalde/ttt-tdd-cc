require 'referee.rb'
require 'board.rb'

describe "Referee" do
  let(:referee) { Referee.new }

  it "returns horizontal winner" do
    board = Board.new
    board.put_token_in_board([1, -1], 'X')
    board.put_token_in_board([2, -1], 'X')
    board.put_token_in_board([3, -1], 'X')
    expect(referee.winner?(board)).to eq(true)
  end

  it "returns vertical winner" do
    board1 = Board.new
    board1.put_token_in_board([1, -1], 'X')
    board1.put_token_in_board([4, -1], 'X')
    board1.put_token_in_board([7, -1], 'X')
    expect(referee.winner?(board1)).to eq(true)
  end

  it "returns diagonal winner" do
    board2 = Board.new
    board2.put_token_in_board([1, -1], 'X')
    board2.put_token_in_board([5, -1], 'X')
    board2.put_token_in_board([9, -1], 'X')
    expect(referee.winner?(board2)).to eq(true)
  end

  it "returns true if tie exists" do
    board = Board.new
    board.tokens = {
                   0 => 'O', 1 => 'X', 2 => 'X',
                   3 => 'X', 4 => 'X', 5 => 'O',
                   6 => 'O', 7 => 'O', 8 => 'X'
                  }
    expect(referee.tie?(board)).to eq(true)
  end

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      board = Board.new
      board.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(board)).to eq(false)

      board.put_token_in_board([9, -1], 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(false)
    end

    it "returns true if there's a winner" do
      board = Board.new
      board.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => '9'
                    }
      expect(referee.game_over?(board)).to eq(false)

      board.put_token_in_board([1, -1], 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
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
      board.put_token_in_board([1, -1], 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      board = Board.new
      board.tokens = {
                     0 => 'O', 1 => 'X', 2 => 'O',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'X', 7 => 'O', 8 => '9'
                    }
      board.put_token_in_board([9, -1], 'O')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      board = Board.new
      board.tokens = {
                     0 => '1', 1 => 'X', 2 => 'X',
                     3 => 'X', 4 => 'X', 5 => 'O',
                     6 => 'O', 7 => 'O', 8 => 'X'
                    }
      board.put_token_in_board([1, -1], 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end
  end
end
