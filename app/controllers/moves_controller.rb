class MovesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @game = Game.find(params[:game_id])
    player = @game.current_turn_player
    position = params[:position].to_i

    game_service = GameService.new(@game)
    if game_service.make_move(player, position)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("game_board", partial: "games/board", locals: { game: @game }),
            turbo_stream.replace("game_status", partial: "games/status", locals: { game: @game })
          ]
        end
        format.html { redirect_to @game }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error_message", partial: "shared/error", locals: { message: "Invalid move" }) }
        format.html { redirect_to @game, alert: "Invalid move" }
      end
    end
  end
end
