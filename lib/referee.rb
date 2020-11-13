class Referee
  def possible_moves(data_translator, game)
    data_translator.get_tokens(game).reject { |token| token == 'X' || token == 'O' }
  end

  def winner?(data_translator, game)
    all_board = rows(data_translator, game) + columns(data_translator, game) + diagonals(game)

    all_board.each do |combination|
      return true if combination.uniq == ['X'] || combination.uniq == ['O']
    end
    false
  end

  def tie?(data_translator, game)
    possible_moves(data_translator, game).length.zero? && !winner?(data_translator, game)
  end

  def game_over?(data_translator, game)
    winner?(data_translator, game) || possible_moves(data_translator, game).length.zero?
  end

  def winner_token(data_translator, game)
    all_board = rows(data_translator, game) + columns(data_translator, game) + diagonals(game)

    all_board.each do |combination|
      return combination.uniq.first if combination.uniq.length == 1
    end
  end

  private
    def rows(data_translator, game)
      data_translator.get_tokens(game).each_slice(3).to_a
    end

    def columns(data_translator, game)
      rows(data_translator, game).transpose
    end

    def diagonals(game)
      [[game.tokens[0], game.tokens[4], game.tokens[8]], [game.tokens[2], game.tokens[4], game.tokens[6]]]
    end
end
