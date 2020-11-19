class UI
  def print(board)
    <<-EOS
        [#{board.get_token_at(1)},#{board.get_token_at(2)},#{board.get_token_at(3)}]
        [#{board.get_token_at(4)},#{board.get_token_at(5)},#{board.get_token_at(6)}]
        [#{board.get_token_at(7)},#{board.get_token_at(8)},#{board.get_token_at(9)}]
    EOS
  end

  def receive_token_coordinate(user_input1 = gets.chomp, user_input2 = gets.chomp)
    [user_input1.to_i, user_input2.to_i]
  end

  def prints_user_instructions
    puts 'Select coordinate between 1 and 9'
  end
end
