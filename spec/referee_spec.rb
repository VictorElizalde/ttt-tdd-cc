$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'referee'
require 'board'

describe "Referee" do
  let(:referee) { Referee.new }
  let(:board) { Board.new }

  def set_board_values(board, array_values)
    array_values.each_with_index do |val, index|
      board.set_token_at(index + 1, val)
    end
  end

  it "returns horizontal winner" do
    set_board_values(board, %w(
      X X X
      _ _ _
      _ _ _
    ))

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns vertical winner" do
    set_board_values(board, %w(
      X _ _
      X _ _
      X _ _
    ))

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns diagonal winner" do
    set_board_values(board, %w(
      X _ _
      _ X _
      _ _ X
    ))

    expect(referee.winner?(board)).to eq(true)
  end

  it "returns true if tie exists" do
    set_board_values(board, %w(
      O X X
      X X O
      O O X
    ))

    expect(referee.tie?(board)).to eq(true)
  end

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      set_board_values(board, %w(
        O X X
        X X O
        O O _
      ))

      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(9, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(false)
    end

    it "returns true if there's a winner" do
      set_board_values(board, %w(
        _ X X
        X X O
        O O _
      ))

      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
    end
  end

  describe "#winner_token" do
    it "returns 'X' as row winner token" do
      set_board_values(board, %w(
        _ X X
        X X O
        O O _
      ))

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      set_board_values(board, %w(
        O X O
        X X O
        X O _
      ))

      board.set_token_at(9, 'O')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      set_board_values(board, %w(
        _ X X
        X X O
        O O X
      ))

      board.set_token_at(1, 'X')

      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end
  end
end
