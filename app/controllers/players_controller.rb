class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to new_game_path(player_id: @player.id)
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
