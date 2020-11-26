require File.join(File.dirname(__FILE__), '..', 'lib', 'board')
require File.join(File.dirname(__FILE__), '..', 'lib', 'computer')
require File.join(File.dirname(__FILE__), '..', 'lib', 'human')
require File.join(File.dirname(__FILE__), '..', 'lib', 'referee')
require File.join(File.dirname(__FILE__), '..', 'lib', 'game')

describe "Game" do
  let(:game) { Game.new(Board.new, Human.new('X'), Computer.new('O'), UI.new, Referee.new) }

  def set_board_values(board, hash_values)
    game.board.tokens = hash_values
  end

  it "returns tie" do
    set_board_values(game.board, {
      0 => 'X', 1 => 'X', 2 => 'O',
      3 => 'O', 4 => 'X', 5 => 'X',
      6 => 'X', 7 => 'O', 8 => 'O'
    })

    expect(game.evaluate_game).to eq("Tie")
  end

  it "returns 'X' as winner token" do
    set_board_values(game.board, {
      0 => 'X', 1 => 'X', 2 => 'O',
      3 => 'O', 4 => 'X', 5 => 'X',
      6 => 'X', 7 => 'O', 8 => 'X'
    })

    expect(game.evaluate_game).to eq('X')
  end

  it "returns 'O' as winner token" do
    set_board_values(game.board, {
      0 => 'X', 1 => 'X', 2 => 'O',
      3 => 'O', 4 => 'X', 5 => 'X',
      6 => 'O', 7 => 'O', 8 => 'O'
    })

    expect(game.evaluate_game).to eq('O')
  end

  it "changes turn of game" do
    expect(game.human_turn).to eq(true)

    game.change_turn

    expect(game.human_turn).to eq(false)
  end

  it "makes a move with computer" do
    set_board_values(game.board, {
      0 => 'O', 1 => 'X', 2 => 'X',
      3 => 'X', 4 => 'X', 5 => 'O',
      6 => '7', 7 => 'O', 8 => 'X'
    })

    game.computer_move

    expect(game.board.get_token_at(7)).to eq 'O'
  end

  it "sets player token in board" do
    expect(game.board.get_token_at(1)).to eq('1')

    game.human_move

    expect(game.board.get_token_at(1)).to eq('X')
  end

  it "does not puts the token because location is already taken" do
    user_input1 = '0'
    user_input2 = '0'
    set_board_values(game.board, {
      0 => 'X', 1 => '2', 2 => '3',
      3 => '4', 4 => '5', 5 => '6',
      6 => '7', 7 => '8', 8 => '9'
    })

    expect(game.board.get_token_at(1)).to eq('1')

    game.human_move

    expect(game.board.get_token_at(1)).to eq('1')
  end
end
