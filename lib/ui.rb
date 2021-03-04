class UI
  def print(board, stdout: $stdout)
    stdout.puts <<-EOS
        [#{board.get_token_at(1)},#{board.get_token_at(2)},#{board.get_token_at(3)}]
        [#{board.get_token_at(4)},#{board.get_token_at(5)},#{board.get_token_at(6)}]
        [#{board.get_token_at(7)},#{board.get_token_at(8)},#{board.get_token_at(9)}]
    EOS
  end

  def prints_user_instructions(stdout: $stdout)
    stdout.puts <<-EOS
        Select coordinate, x: 0 - 2, y: 0 - 2
    EOS
  end

  def prints_invalid_move(stdout: $stdout)
    stdout.puts <<-EOS
        Invalid move, try again
    EOS
    "Invalid move, try again"
  end

  def print_tie(stdout: $stdout)
    stdout.puts <<-EOS
        Tie!
    EOS
    "Tie!"
  end

  def print_winner(winner_token, stdout: $stdout)
    stdout.puts <<-EOS
        Winner is #{winner_token}!
    EOS
    "Winner is #{winner_token}!"
  end

  def print_computer_turn(stdout: $stdout)
    stdout.puts <<-EOS
        Computer\'s turn
    EOS
  end

  def ask_for_input_type(stdout: $stdout)
    stdout.puts <<-EOS
        Select input
        1: terminal input
        2: web browser input
    EOS
  end
end
