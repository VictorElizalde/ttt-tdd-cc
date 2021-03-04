class TerminalInput
  def get_input(user_input1 = nil, user_input2 = nil, stdin: $stdin)
    user_input1 = stdin.gets.chomp if user_input1.nil?
    user_input2 = stdin.gets.chomp if user_input2.nil?
    [user_input1.to_i, user_input2.to_i]
  end
end