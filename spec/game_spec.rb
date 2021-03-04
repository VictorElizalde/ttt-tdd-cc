$LOAD_PATH.unshift File.expand_path(".", "lib")
require 'board'
require 'computer'
require 'human'
require 'referee'
require 'game'
require 'ui'
require 'terminal_input'
require 'browser_input'
require 'curler'
require 'file_handler'

describe "Game" do
  let(:referee) { Referee.new }
  let(:game) { Game.new(Board.new, UI.new, referee, [Human.new('X', TerminalInput.new, BrowserInput.new), Computer.new('O', referee)], "1", Curler.new, FileHandler.new) }

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

    file = File.open("ttt_board.html")
    file_data = file.read

    expect(file_data).to include("<a>| </a><a>X</a><a> | </a><a>X</a><a> | </a><a>O</a><a> |</a> <br>")
    expect(file_data).to include("<h2>Winner is X!</h2>")
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

    file = File.open("ttt_board.html")
    file_data = file.read

    expect(file_data).to include("<a>| </a><a>O</a><a> | </a><a>X</a><a> | </a><a>X</a><a> |</a> <br>")
    expect(file_data).to include("<h2>Winner is X!</h2>")
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

    file = File.open("ttt_board.html")
    file_data = file.read

    expect(file_data).to include("<a>| </a><a>O</a><a> | </a><a>O</a><a> | </a><a>O</a><a> |</a> <br>")
    expect(file_data).to include("<h2>Winner is O!</h2>")
  end

  it "makes a move with computer" do
    game = Game.new(Board.new, UI.new, referee, [Computer.new('O', referee), Human.new('X', TerminalInput.new, BrowserInput.new)], "1", Curler.new, FileHandler.new)
    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))

    expect{ game.play_game }.to output(<<-EOS
        Select input
        1: terminal input
        2: web browser input
        Computer's turn
        [O,X,X]
        [X,X,O]
        [O,O,X]
        Tie!
      EOS
    ).to_stdout

    expect(game.board.get_token_at(7)).to eq 'O'

    file = File.open("ttt_board.html")
    file_data = file.read

    expect(file_data).to include("<h1>TTT Board</h1>")
    expect(file_data).to include("<h2>Tie!</h2>")
  end

  it "prints tie because game is over" do
    set_board_values(game.board, %w(
      O X X
      X X O
      O O X
    ))

    expect { game.play_game }.to output(<<-EOS
        Select input
        1: terminal input
        2: web browser input
        [O,X,X]
        [X,X,O]
        [O,O,X]
        Tie!
      EOS
    ).to_stdout

    file = File.open("ttt_board.html")
    file_data = file.read

    expect(file_data).to include("<h2>Tie!</h2>")
  end

  it "prints winner is O because computer did last move" do
    game = Game.new(Board.new, UI.new, referee, [Computer.new('O', referee), Human.new('X', TerminalInput.new, BrowserInput.new)], "1", Curler.new, FileHandler.new)
    set_board_values(game.board, %w(
      O X X
      X X O
      O O 9
    ))

    expect { game.play_game }.to output(<<-EOS
        Select input
        1: terminal input
        2: web browser input
        Computer's turn
        [O,X,X]
        [X,X,O]
        [O,O,O]
        Winner is O!
      EOS
    ).to_stdout

    file = File.open("ttt_board.html")
    file_data = file.read
    expect(file_data).to include("<h2>Winner is O!</h2>")
  end

  it "prints winner is X because human won" do
    set_board_values(game.board, %w(
      O X X
      X X O
      X O X
    ))

    expect { game.play_game }.to output(<<-EOS 
        Select input
        1: terminal input
        2: web browser input
        [O,X,X]
        [X,X,O]
        [X,O,X]
        Winner is X!
      EOS
    ).to_stdout

    file = File.open("ttt_board.html")
    file_data = file.read
    expect(file_data).to include("<h2>Winner is X!</h2>")
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
    game = Game.new(Board.new, UI.new, referee, [Human.new('X', TerminalInput.new, BrowserInput.new)], "1", Curler.new, FileHandler.new)

    set_board_values(game.board, %w(
      O X X
      X X O
      7 O X
    ))
    user_input1 = 2
    user_input2 = 0
    expect(game.board.get_token_at(7)).to eq('7')
    
    expect { game.players.first.did_move?(game.board, game.ui, "1", [user_input1,user_input2]) }.to output(<<-EOS 
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

  it "receives user input for input type" do
    user_input = '1'

    expect(game.get_input_type(user_input)).to eq('1')
  end

  it "accepts value for input type" do
    game.input_type = "1"
    expect { game.set_input_type_for_game }.to output(<<-EOS
        Select input
        1: terminal input
        2: web browser input
      EOS
    ).to_stdout
    expect(game.input_type).to eq("1")
  end
end
