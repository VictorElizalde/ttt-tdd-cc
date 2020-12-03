$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'computer'
require 'human'
require 'referee'
require 'game'
require 'ui'


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

    expect{ game.print_results }.to output(<<-EOS
        Tie!
      EOS
    ).to_stdout
  end

  it "returns 'X' as winner token" do
    set_board_values(game.board, %w(
      X X O
      O X X
      X O X
    ))

    expect{ game.print_results }.to output(<<-EOS
        Winner is X!
      EOS
    ).to_stdout
  end

  it "returns 'O' as winner token" do
    set_board_values(game.board, %w(
      X X O
      O X X
      O O O
    ))

    expect{ game.print_results }.to output(<<-EOS
        Winner is O!
      EOS
    ).to_stdout
  end

  it "is the human turn always in the first move" do
    expect(game.human_turn).to eq(true)
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

    expect{ game.computer_move }.to output(<<-EOS
        Computer's turn
      EOS
    ).to_stdout

    expect(game.board.get_token_at(7)).to eq 'O'
  end

  it "sets player token in board" do
    expect(game.board.get_token_at(1)).to eq('1')

    game.human_move_succesful?([0,0])

    expect(game.board.get_token_at(1)).to eq('X')
  end

  it "does not put the token because location is already taken" do
    user_input1 = 0
    user_input2 = 0
    set_board_values(game.board, %w(
      O _ _
      _ _ _
      _ _ _
    ))

    expect(game.board.get_token_at(1)).to eq('O')

    game.human_move_succesful?([user_input1,user_input2])

    expect(game.board.get_token_at(1)).to eq('O')
  end

  it "prints tie because game is over" do
    set_board_values(game.board, %w(
      O X X
      X X O
      O O X
    ))

    expect { game.play_game }.to output(<<-EOS
        [O,X,X]
        [X,X,O]
        [O,O,X]
        Tie!
      EOS
    ).to_stdout
  end

  it "prints winner is O because computer did last move" do
    set_board_values(game.board, %w(
      O X X
      X X O
      O O 9
    ))

    game.change_turn

    expect { game.play_game }.to output(<<-EOS 
        Computer's turn
        [O,X,X]
        [X,X,O]
        [O,O,O]
        Winner is O!
      EOS
    ).to_stdout
    expect(game.human_turn).to eq(true)
  end

  it "prints winner is X because human won" do
    set_board_values(game.board, %w(
      O X X
      X X O
      X O X
    ))

    expect { game.play_game }.to output(<<-EOS 
        [O,X,X]
        [X,X,O]
        [X,O,X]
        Winner is X!
      EOS
    ).to_stdout
  end

  it "prints board when game is finished" do
    set_board_values(game.board, %w(
      O X X
      X X O
      O O X
    ))

    expect{ game.run_turns }.to output(<<-EOS
        [O,X,X]
        [X,X,O]
        [O,O,X]
      EOS
    ).to_stdout
  end

  it "makes human move to win the match" do
    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))
    user_input1 = 2
    user_input2 = 0
    expect(game.board.get_token_at(7)).to eq('7')
    
    expect { game.run_turns([user_input1,user_input2]) }.to output(<<-EOS 
        [O,X,X]
        [X,X,O]
        [7,O,X]
        Select coordinate, x: 0 - 2, y: 0 - 2
        [O,X,X]
        [X,X,O]
        [X,O,X]
      EOS
    ).to_stdout
    expect(game.board.get_token_at(7)).to eq('X')
    expect { game.print_results }.to output(<<-EOS
        Winner is X!
      EOS
    ).to_stdout
  end
end
