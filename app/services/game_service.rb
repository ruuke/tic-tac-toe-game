class GameService
  def initialize(game)
    @game = game
  end

  def make_move(player, position)
    return false unless valid_move?(player, position)

    Move.create!(game: @game, player: player, position: position)
    check_game_status
    switch_turns

    true
  end

  private

  def valid_move?(player, position)
    @game.current_turn == player && @game.moves.where(position: position).none?
  end

  def check_game_status
    if winner?
      @game.update(status: 'finished')
    elsif @game.moves.count == 9
      @game.update(status: 'finished')
    end
  end

  def winner?
    # Логика проверки победителя
  end

  def switch_turns
    @game.update(current_turn: @game.current_turn == 'X' ? 'O' : 'X')
  end
end
