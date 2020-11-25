require File.join(File.dirname(__FILE__), '..', 'lib', 'referee')
require File.join(File.dirname(__FILE__), '..', 'lib', 'board')

describe "Referee" do
  let(:referee) { Referee.new }
  let(:board) { Board.new }

  def set_board_values(board, hash_values)
    board.tokens = hash_values
  end

  it "returns horizontal winner" do
    set_board_values(board, {
      0 => 'X', 1 => 'X', 2 => 'X',
      3 => '4', 4 => '5', 5 => '6',
      6 => '5', 7 => '8', 8 => '9'
    })

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns vertical winner" do
    set_board_values(board, {
      0 => 'X', 1 => '2', 2 => '3',
      3 => 'X', 4 => '5', 5 => '6',
      6 => 'X', 7 => '8', 8 => '9'
    })

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns diagonal winner" do
    set_board_values(board, {
      0 => 'X', 1 => '2', 2 => '3',
      3 => '4', 4 => 'X', 5 => '6',
      6 => '7', 7 => '8', 8 => 'X'
    })

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns true if tie exists" do
    set_board_values(board, {
      0 => 'O', 1 => 'X', 2 => 'X',
      3 => 'X', 4 => 'X', 5 => 'O',
      6 => 'O', 7 => 'O', 8 => 'X'
    })

    expect(referee.tie?(board)).to eq(true)
  end

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      set_board_values(board, {
        0 => 'O', 1 => 'X', 2 => 'X',
        3 => 'X', 4 => 'X', 5 => 'O',
        6 => 'O', 7 => 'O', 8 => '9'
      })

      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(9, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(false)
    end

    it "returns true if there's a winner" do
      set_board_values(board, {
        0 => '1', 1 => 'X', 2 => 'X',
        3 => 'X', 4 => 'X', 5 => 'O',
        6 => 'O', 7 => 'O', 8 => '9'
      })

      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
    end
  end

  describe "#winner_token" do
    it "returns 'X' as row winner token" do
      set_board_values(board, {
        0 => '1', 1 => 'X', 2 => 'X',
        3 => 'X', 4 => 'X', 5 => 'O',
        6 => 'O', 7 => 'O', 8 => '9'
      })

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      set_board_values(board, {
        0 => 'O', 1 => 'X', 2 => 'O',
        3 => 'X', 4 => 'X', 5 => 'O',
        6 => 'X', 7 => 'O', 8 => '9'
      })

      board.set_token_at(9, 'O')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      set_board_values(board, {
        0 => '1', 1 => 'X', 2 => 'X',
        3 => 'X', 4 => 'X', 5 => 'O',
        6 => 'O', 7 => 'O', 8 => 'X'
      })

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end
  end
end
