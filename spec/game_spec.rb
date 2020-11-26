$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'computer'
require 'human'
require 'referee'
require 'game'


describe "Game" do
  let(:game) { Game.new(Board.new, Human.new('X'), Computer.new('O'), UI.new, Referee.new) }

  def set_board_values(board, array_values)
    array_values.each_with_index do |val, index|
      board.set_token_at(index + 1, val)
    end
  end

  it "returns tie" do
    set_board_values(game.board, %w(
      X X O
      O X X
      X O O
    ))

    expect(game.evaluate_game).to eq("Tie")
  end

  it "returns 'X' as winner token" do
    set_board_values(game.board, %w(
      X X O
      O X X
      X O X
    ))

    expect(game.evaluate_game).to eq('X')
  end

  it "returns 'O' as winner token" do
    set_board_values(game.board, %w(
      X X O
      O X X
      O O O
    ))

    expect(game.evaluate_game).to eq('O')
  end

  it "changes turn of game" do
    expect(game.human_turn).to eq(true)

    game.change_turn

    expect(game.human_turn).to eq(false)
  end

  it "makes a move with computer" do
    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))

    game.computer_move

    expect(game.board.get_token_at(7)).to eq 'O'
  end

  it "sets player token in board" do
    expect(game.board.get_token_at(1)).to eq('1')

    game.human_move_succesful?([0,0])

    expect(game.board.get_token_at(1)).to eq('X')
  end

  it "does not put the token because location is already taken" do
    user_input1 = '0'
    user_input2 = '0'
    set_board_values(game.board, %w(
      O _ _
      _ _ _
      _ _ _
    ))

    expect(game.board.get_token_at(1)).to eq('O')

    game.human_move_succesful?([0,0])

    expect(game.board.get_token_at(1)).to eq('O')
  end
end
