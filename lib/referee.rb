class Referee
  def possible_moves(board)
    board.get_tokens.reject { |token| token == 'X' || token == 'O' }
  end

  def winner?(board)
    all_board = board.rows + board.columns + board.diagonals

    all_board.each do |combination|
      return true if combination.uniq == ['X'] || combination.uniq == ['O']
    end
    false
  end

  def tie?(board)
    possible_moves(board).length.zero? && !winner?(board)
  end

  def game_over?(board)
    winner?(board) || possible_moves(board).length.zero?
  end

  def winner_token(board)
    all_board = board.rows + board.columns + board.diagonals()

    all_board.each do |combination|
      return combination.uniq.first if combination.uniq.length == 1
    end
  end
end
