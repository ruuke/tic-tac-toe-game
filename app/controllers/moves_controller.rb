class MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    player = Player.find(params[:player_id])
    position = params[:position].to_i

    game_service = GameService.new(@game)
    if game_service.make_move(player, position)
      render json: @game
    else
      render json: { error: 'Invalid move' }, status: :unprocessable_entity
    end
  end
end
