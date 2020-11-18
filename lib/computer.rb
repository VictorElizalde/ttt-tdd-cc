require_relative 'player'

class Computer < Player
  attr_reader :optimal_move

  def make_move(board, referee)
    minimax(board, referee, @token, 0)
    board.put_token_in_board([@optimal_move.to_i, -1], @token)
  end

  private

  def minimax(board, referee, token, depth)
    scores = []
    moves = []

    return score(board, referee, depth) if referee.game_over?(board)

    referee.possible_moves(board).each do |move|
      board.put_token_in_board([move.to_i, -1], token)

      next_player = @token == token ? @enemy_token : @token
      scores << minimax(board, referee, next_player, depth + 1)
      moves << move

      board.reset_token_at(move.to_i)
    end

    if @token == token
      @optimal_move = moves[scores.each_with_index.max[1]]
      return scores[scores.each_with_index.max[1]]
    else
      @optimal_move = moves[scores.each_with_index.min[1]]
      return scores[scores.each_with_index.min[1]]
    end
  end

  def score(board, referee, depth)
    best_score = 10

    if referee.winner?(board)
      if referee.winner_token(board) == @token
        return (best_score - depth)
      else
        return (depth - best_score)
      end
    else
      return 0
    end
  end
end
