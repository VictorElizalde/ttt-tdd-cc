class Referee
  def possible_moves(board)
    board.tokens.reject { |token| token == 'X' || token == 'O' }
  end

  def rows(board)
    board.tokens.each_slice(3).to_a
  end

  def columns(board)
    board.tokens.each_slice(3).to_a.transpose
  end

  def diagonals(board)
    [[board.tokens[0], board.tokens[4], board.tokens[8]], [board.tokens[2], board.tokens[4], board.tokens[6]]]
  end

  def row_winner?(board)
    rows(board).each do |row|
      return true if row.uniq == ['X'] || row.uniq == ['O']
    end
    false
  end

  def column_winner?(board)
    columns(board).each do |column|
      return true if column.uniq == ['X'] || column.uniq == ['O']
    end
    false
  end

  def diagonal_winner?(board)
    diagonals(board).each do |diagonal|
      return true if diagonal.uniq == ['X'] || diagonal.uniq == ['O']
    end
    false
  end

  def winner?(board)
    row_winner?(board) || column_winner?(board) || diagonal_winner?(board)
  end

  def tie?(board)
    possible_moves(board).length.zero? && !winner?(board)
  end

  def game_over?(board)
    winner?(board) || possible_moves(board).length.zero?
  end

  def winner_token?(board)
    rows(board).each do |row|
      return row.uniq.first if row.uniq.length == 1
    end

    columns(board).each do |column|
      return column.uniq.first if column.uniq.length == 1
    end

    diagonals(board).each do |diagonal|
      return diagonal.uniq.first if diagonal.uniq.length == 1
    end
  end
end
