require_relative 'player'

class Computer < Player
  attr_reader :optimal_move

  def make_move(data_translator, game, board, referee)
    minimax(data_translator, game, board, referee, @token, 0)
    board.set_token_at(game, @optimal_move.to_i, @token)
  end

  private

  def minimax(data_translator, game, board, referee, token, depth)
    scores = []
    moves = []

    return score(data_translator, game, referee, depth) if referee.game_over?(data_translator, game)

    referee.possible_moves(data_translator, game).each do |move|
      board.set_token_at(game, move.to_i, token)

      next_player = @token == token ? @enemy_token : @token
      scores << minimax(data_translator, game, board, referee, next_player, depth + 1)
      moves << move

      board.reset_token_at(game, move.to_i)
    end

    if @token == token
      @optimal_move = moves[scores.each_with_index.max[1]]
      return scores[scores.each_with_index.max[1]]
    else
      @optimal_move = moves[scores.each_with_index.min[1]]
      return scores[scores.each_with_index.min[1]]
    end
  end

  def score(data_translator, game, referee, depth)
    best_score = 10

    if referee.winner?(data_translator, game)
      if referee.winner_token(data_translator, game) == @token
        return (best_score - depth)
      else
        return (depth - best_score)
      end
    else
      return 0
    end
  end
end
