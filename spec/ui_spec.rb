require 'ui.rb'
require 'board.rb'
require 'game.rb'

describe "UI" do
  let(:ui) { UI.new }
  let(:board) { Board.new }
  let(:data_translator) { DataTranslator.new }

  it "prints empty board with 1 to 9 coordinates" do
    game = Game.new
    expect(ui.print(game)).to eq(<<-EOS
        [1,2,3]
        [4,5,6]
        [7,8,9]
      EOS
    )
  end

  it "prints board with player marks" do
    game = Game.new
    board.set_token_at(game, 5, "X")
    board.set_token_at(game, 9, "O")
    expect(ui.print(game)).to eq(<<-EOS
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
    game = Game.new
    user_input1 = '1'
    user_input2 = '1'
    expect(ui.receive_token_coordinate(user_input1, user_input2)).to eq([1, 1])
    expect(board.get_token_at(game, 1)).to eq('1')
    board.set_user_token_at(data_translator, game, ui.receive_token_coordinate(user_input1, user_input2), 'X')
    expect(board.get_token_at(game, 5)).to eq('X')
  end
end
