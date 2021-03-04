class Game
  attr_reader :board, :ui, :referee, :players, :curler, :file_handler
  attr_accessor :input_type

  def initialize(board, ui, referee, players_array, input_type, curler, file_handler)
    @board = board
    @ui = ui
    @referee = referee
    @players = players_array
    @input_type = input_type
    @curler = curler
    @file_handler = file_handler
  end

  def play_game
    set_input_type_for_game
    run_turns
    print_results
  end

  def print_results
    File.write("ttt_board.html", "<h2>#{@referee.evaluate_game(@board, @ui)}</h2>", mode: "a")
    @curler.update_browser_view
  end

  def run_turns
    i = 0
    until @referee.game_over?(@board) || @referee.winner?(@board)
      if i == @players.size
        i = 0
      end

      player_on_turn = @players[i]
      
      until player_on_turn.did_move?(@board, @ui, @input_type)
        @ui.prints_invalid_move
      end

      response = @curler.request_html_to_server(@board.get_tokens.join(" "))
      @file_handler.create_html_file_with_response(response)
      @curler.update_browser_view

      i += 1
    end

    @ui.print(@board)
  end

  def get_input_type(input_type = nil, stdin: $stdin)
    input_type = stdin.gets.chomp if input_type.nil?
    input_type
  end

  def set_input_type_for_game
    loop do
      @ui.ask_for_input_type
      @input_type = get_input_type() if @input_type.nil?
      break if @input_type == "1" || @input_type == "2"
    end
  end
end
