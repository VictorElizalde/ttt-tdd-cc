class UI
  def print(game)
    <<-EOS
        [#{game.tokens[0]},#{game.tokens[1]},#{game.tokens[2]}]
        [#{game.tokens[3]},#{game.tokens[4]},#{game.tokens[5]}]
        [#{game.tokens[6]},#{game.tokens[7]},#{game.tokens[8]}]
    EOS
  end

  def receive_token_coordinate(user_input = gets.chomp)
    user_input.to_i
  end

  def prints_user_instructions
    puts 'Select coordinate between 1 and 9'
  end
end
