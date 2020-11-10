class UI
  def print(board)
    <<-EOS
        [#{board.tokens[0]},#{board.tokens[1]},#{board.tokens[2]}]
        [#{board.tokens[3]},#{board.tokens[4]},#{board.tokens[5]}]
        [#{board.tokens[6]},#{board.tokens[7]},#{board.tokens[8]}]
    EOS
  end

  def receive_token_coordinate(user_input = gets.chomp)
    user_input.to_i
  end

  def prints_user_instructions
    puts 'Select coordinate between 1 and 9'
  end
end
