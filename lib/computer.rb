require 'player'

class Computer < Player
  attr_reader :optimal_move, :enemy_token, :referee

  def initialize(token, referee)
    super(token)
    @enemy_token = @token == 'X' ? 'O' : 'X'
    @referee = referee
  end

  def did_move?(board, ui, input_type = nil)
    ui.print_computer_turn

    minimax(board, @token, 0)
    board.set_token_at(@optimal_move.to_i, @token)
    return true
  end

  private

  def minimax(board, token, depth)
    scores = []
    moves = []

    return score(board, depth) if @referee.game_over?(board)

    @referee.possible_moves(board).each do |move|
      board.set_token_at(move.to_i, token)

      next_player = @token == token ? @enemy_token : @token
      scores << minimax(board, next_player, depth + 1)
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

  def score(board, depth)
    best_score = 10

    if @referee.winner?(board)
      if @referee.winner_token(board) == @token
        return (best_score - depth)
      else
        return (depth - best_score)
      end
    else
      return 0
    end
  end
end
