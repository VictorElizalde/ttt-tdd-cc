
class UI
  def print(board)
    <<-EOS
          [#{board.tokens[0]},#{board.tokens[1]},#{board.tokens[2]}]
          [#{board.tokens[3]},#{board.tokens[4]},#{board.tokens[5]}]
          [#{board.tokens[6]},#{board.tokens[7]},#{board.tokens[8]}]
    EOS
  end
end

class Board
  attr_accessor :tokens

  def initialize
    self.tokens = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def get_token_at(pos)
    tokens[pos - 1]
  end

  def set_token_at(pos, mark)
    tokens[pos - 1] = mark
  end
end

class Referee
  def possible_moves(board)
    board.tokens.reject { |token| token == 'X' || token == 'O' }
  end

  def row_winner?(board)
    rows = board.tokens.each_slice(3).to_a
    rows.each do |row|
      return true if row.uniq == ['X'] || row.uniq == ['O']
    end
    false
  end

  def column_winner?(board)
    columns = board.tokens.each_slice(3).to_a.transpose
    columns.each do |column|
      return true if column.uniq == ['X'] || column.uniq == ['O']
    end
    false
  end

  def diagonal_winner?(board)
    diagonals = [[board.tokens[0], board.tokens[4], board.tokens[8]], [board.tokens[2], board.tokens[4], board.tokens[6]]]
    diagonals.each do |diagonal|
      return true if diagonal.uniq == ['X'] || diagonal.uniq == ['O']
    end
    false
  end

  def winner?(board)
    row_winner?(board) || column_winner?(board) || diagonal_winner?(board)
  end

  def tie?(board)
    possible_moves(board).length.zero? && !winner?(board)
  end

  def game_over?(board)
    winner?(board) || possible_moves(board).length.zero?
  end
end

describe "Board" do
  let(:board) { Board.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(7)).to eq('7')
    board.set_token_at(7, 'X')
    expect(board.get_token_at(7)).to eq('X')
  end
end

describe "Referee" do
  let(:referee) { Referee.new }

  it "returns possible moves" do
    board = Board.new
    board.set_token_at(1, 'X')
    expect(referee.possible_moves(board)).to eq(["2","3","4","5","6","7","8","9"])
  end

  it "returns winner for any of the rules to win" do
    board = Board.new
    board.set_token_at(1, 'X')
    board.set_token_at(2, 'X')
    board.set_token_at(3, 'X')
    expect(referee.winner?(board)).to eq(true)

    board1 = Board.new
    board1.set_token_at(1, 'X')
    board1.set_token_at(4, 'X')
    board1.set_token_at(7, 'X')
    expect(referee.winner?(board1)).to eq(true)

    board2 = Board.new
    board2.set_token_at(1, 'X')
    board2.set_token_at(5, 'X')
    board2.set_token_at(9, 'X')
    expect(referee.winner?(board2)).to eq(true)
  end

  it "returns true if row winner exists" do
    board = Board.new
    board.set_token_at(1, 'X')
    board.set_token_at(2, 'X')
    board.set_token_at(3, 'X')
    expect(referee.row_winner?(board)).to eq(true)
  end

  it "returns true if column winner exists" do
    board = Board.new
    board.set_token_at(1, 'X')
    board.set_token_at(4, 'X')
    board.set_token_at(7, 'X')
    expect(referee.column_winner?(board)).to eq(true)
  end

  it "returns true if diagonal winner exists" do
    board = Board.new
    board.set_token_at(3, 'X')
    board.set_token_at(5, 'X')
    board.set_token_at(7, 'X')
    expect(referee.diagonal_winner?(board)).to eq(true)
  end

  it "returns true if tie exists" do
    board = Board.new
    board.tokens = %w(O X X
                      X X O
                      O O X)
    expect(referee.tie?(board)).to eq(true)
  end

  it "returns true if game is over either by tie or a winner exists" do
    board = Board.new
    board.tokens = %w(O X X
                      X X O
                      O O X)
    expect(referee.game_over?(board)).to eq(true)
  end
end

describe "UI" do
    let(:ui) { UI.new }

    it "prints empty board with 1 to 9 coordinates" do
      board = Board.new
      expect(ui.print(board)).to eq(<<-EOS
          [1,2,3]
          [4,5,6]
          [7,8,9]
        EOS
      )
    end

    it "prints board with player marks" do
      board = Board.new
      board.set_token_at(5, "X")
      board.set_token_at(9, "O")
      expect(ui.print(board)).to eq(<<-EOS
          [1,2,3]
          [4,X,6]
          [7,8,O]
        EOS
      )
    end
end
