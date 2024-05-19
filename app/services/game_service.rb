class GameService
  def initialize(game)
    @game = game
  end

  def make_move(player, position)
    return false unless valid_move?(player, position)

    @game.moves.create(player: player, position: position)
    switch_turns
    check_game_status
    true
  end

  private

  def valid_move?(player, position)
    position.between?(0, 8) && @game.moves.where(position: position).none?
  end

  def check_game_status
    if winner?
      @game.update(status: 'finished')
    elsif @game.moves.count == 9
      @game.update(status: 'finished')
    end
  end

  def winner?
    winning_combinations.any? do |combination|
      positions = @game.moves.where(position: combination).pluck(:player_id)
      positions.uniq.size == 1 && positions.size == 3
    end
  end

  def winning_combinations
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
      [0, 4, 8], [2, 4, 6]             # diagonals
    ]
  end

  def switch_turns
    @game.current_turn = @game.current_turn == 'X' ? 'O' : 'X'
    @game.save
  end
end
