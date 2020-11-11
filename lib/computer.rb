require_relative 'player'

class Computer < Player
  attr_reader :optimal_move

  def make_move(game, board, referee)
    minimax(game, board, referee, @token, 0)
    board.set_token_at(game, @optimal_move.to_i, @token)
  end

  private

  def minimax(game, board, referee, token, depth)
    scores = []
    moves = []

    return score(game, referee, depth) if referee.game_over?(game)

    referee.possible_moves(game).each do |move|
      board.set_token_at(game, move.to_i, token)

      next_player = @token == token ? @enemy_token : @token
      scores << minimax(game, board, referee, next_player, depth + 1)
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

  def score(game, referee, depth)
    best_score = 10

    if referee.winner?(game)
      if referee.winner_token(game) == @token
        return (best_score - depth)
      else
        return (depth - best_score)
      end
    else
      return 0
    end
  end
end
