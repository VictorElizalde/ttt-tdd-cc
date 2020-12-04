$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'computer'
require 'human'
require 'referee'
require 'game'
require 'ui'


describe "Game" do
  let(:referee) { Referee.new }
  let(:game) { Game.new(Board.new, UI.new, referee, [Human.new('X'), Computer.new('O', referee)]) }

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

  it "makes a move with computer" do
    game = Game.new(Board.new, UI.new, referee, [Computer.new('O', referee), Human.new('X')])
    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))

    expect{ game.play_game }.to output(<<-EOS
        Computer's turn
        [O,X,X]
        [X,X,O]
        [O,O,X]
        Tie!
      EOS
    ).to_stdout

    expect(game.board.get_token_at(7)).to eq 'O'
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
    game = Game.new(Board.new, UI.new, referee, [Computer.new('O', referee), Human.new('X')])
    set_board_values(game.board, %w(
      O X X
      X X O
      O O 9
    ))

    expect { game.play_game }.to output(<<-EOS 
        Computer's turn
        [O,X,X]
        [X,X,O]
        [O,O,O]
        Winner is O!
      EOS
    ).to_stdout
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
    game = Game.new(Board.new, UI.new, referee, [Human.new('X')])

    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))
    user_input1 = 2
    user_input2 = 0
    expect(game.board.get_token_at(7)).to eq('7')
    
    expect { game.players.first.did_move?(game.board, game.ui, [user_input1,user_input2]) }.to output(<<-EOS 
        [O,X,X]
        [X,X,O]
        [7,O,X]
        Select coordinate, x: 0 - 2, y: 0 - 2
      EOS
    ).to_stdout
    expect(game.board.get_token_at(7)).to eq('X')
    expect { game.print_results }.to output(<<-EOS
        Winner is X!
      EOS
    ).to_stdout
  end
end
