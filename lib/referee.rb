class Referee
  def possible_moves(game)
    game.tokens.reject { |token| token == 'X' || token == 'O' }
  end

  def winner?(game)
    all_board = rows(game) + columns(game) + diagonals(game)

    all_board.each do |combination|
      return true if combination.uniq == ['X'] || combination.uniq == ['O']
    end
    false
  end

  def tie?(game)
    possible_moves(game).length.zero? && !winner?(game)
  end

  def game_over?(game)
    winner?(game) || possible_moves(game).length.zero?
  end

  def winner_token(game)
    all_board = rows(game) + columns(game) + diagonals(game)

    all_board.each do |combination|
      return combination.uniq.first if combination.uniq.length == 1
    end
  end

  private
    def rows(game)
      game.tokens.each_slice(3).to_a
    end

    def columns(game)
      game.tokens.each_slice(3).to_a.transpose
    end

    def diagonals(game)
      [[game.tokens[0], game.tokens[4], game.tokens[8]], [game.tokens[2], game.tokens[4], game.tokens[6]]]
    end
end
