class UI
  def print(game)
    <<-EOS
        [#{game.tokens[0]},#{game.tokens[1]},#{game.tokens[2]}]
        [#{game.tokens[3]},#{game.tokens[4]},#{game.tokens[5]}]
        [#{game.tokens[6]},#{game.tokens[7]},#{game.tokens[8]}]
    EOS
  end

  def receive_token_coordinate(user_input1 = gets.chomp, user_input2 = gets.chomp)
    [user_input1.to_i, user_input2.to_i]
  end

  def prints_user_instructions
    puts 'Select coordinate between 1 and 9'
  end
end
