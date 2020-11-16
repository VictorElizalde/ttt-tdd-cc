class Referee
  def possible_moves(data_translator, board)
    data_translator.get_tokens(board.tokens).reject { |token| token == 'X' || token == 'O' }
  end

  def winner?(data_translator, board)
    all_board = board.rows(data_translator) + board.columns(data_translator) + board.diagonals()

    all_board.each do |combination|
      return true if combination.uniq == ['X'] || combination.uniq == ['O']
    end
    false
  end

  def tie?(data_translator, board)
    possible_moves(data_translator, board).length.zero? && !winner?(data_translator, board)
  end

  def game_over?(data_translator, board)
    winner?(data_translator, board) || possible_moves(data_translator, board).length.zero?
  end

  def winner_token(data_translator, board)
    all_board = board.rows(data_translator) + board.columns(data_translator) + board.diagonals()

    all_board.each do |combination|
      return combination.uniq.first if combination.uniq.length == 1
    end
  end
end
