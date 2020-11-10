require 'board.rb'
require 'ui.rb'
require 'referee.rb'
require 'player.rb'
require 'human.rb'
require 'computer.rb'

describe "Board" do
  let(:board) { Board.new }

  it "sets token at empty coordinate" do
    expect(board.get_token_at(7)).to eq('7')
    board.set_token_at(7, 'X')
    expect(board.get_token_at(7)).to eq('X')
  end

  it "resets token at occupied coordinate" do
    board.set_token_at(7, 'X')
    expect(board.get_token_at(7)).to eq('X')
    board.reset_token_at(7)
    expect(board.get_token_at(7)).to eq('7')
  end
end

describe "Referee" do
  let(:referee) { Referee.new }

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

  describe "game_over?" do
    it "returns true if board is full & there's a tie" do
      board = Board.new
      board.tokens = %w(O X X
                        X X O
                        O O _)
      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(9, 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(false)
    end

    it "returns true if there's a winner" do
      board = Board.new
      board.tokens = %w(_ X X
                        X X O
                        O O _)
      expect(referee.game_over?(board)).to eq(false)

      board.set_token_at(1, 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
    end
  end

  describe "#winner_token" do
    it "returns 'X' as row winner token" do
      board = Board.new
      board.tokens = %w(_ X X
                        X X O
                        O O _)
      board.set_token_at(1, 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end

    it "returns 'O' as column winner token" do
      board = Board.new
      board.tokens = %w(O X O
                        X X O
                        X O _)
      board.set_token_at(9, 'O')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('O')
    end

    it "returns X as diagonal winner token" do
      board = Board.new
      board.tokens = %w(_ X X
                        X X O
                        O O X)
      board.set_token_at(1, 'X')
      expect(referee.game_over?(board)).to eq(true)
      expect(referee.winner?(board)).to eq(true)
      expect(referee.winner_token(board)).to eq('X')
    end
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

  it "prints user instruction for token location" do
    expect { ui.prints_user_instructions }.to output("Select coordinate between 1 and 9\n").to_stdout
  end

  it "sets token in user input coordinate" do
    board = Board.new
    user_input = '1'
    expect(ui.receive_token_coordinate(user_input)).to eq(1)
    expect(board.get_token_at(1)).to eq('1')
    board.set_token_at(ui.receive_token_coordinate(user_input), 'X')
    expect(board.get_token_at(1)).to eq('X')
  end
end

describe Human do
  let(:human) { Human.new('X') }

  it "has an enemy token" do
    expect(human.enemy_token).to eq('O')
  end

  it "sets player token in board" do
    board = Board.new
    expect(board.get_token_at(1)).to eq('1')
    human.make_move(board, 1)
    expect(board.get_token_at(1)).to eq('X')
  end
end

describe Computer do
  let(:computer) { Computer.new('O') }

  it "blocks human win" do
    board = Board.new
    referee = Referee.new
    board.set_token_at(1, 'X')
    board.set_token_at(4, 'O')
    board.set_token_at(2, 'X')
    computer.make_move(board, referee)

    expect(board.get_token_at(3)).to eq 'O'
  end
end
