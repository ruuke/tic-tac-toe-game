class GamesController < ApplicationController
  def create
    player_x = Player.find(params[:player_x_id])
    @game = Game.create!(player_x: player_x, current_turn: 'X', status: 'waiting_for_player')
    render json: @game
  end

  def join
    @game = Game.find(params[:id])
    player_o = Player.find(params[:player_o_id])
    if @game.status == 'waiting_for_player'
      @game.update!(player_o: player_o, status: 'in_progress')
    end
    render json: @game
  end

  def show
    @game = Game.find(params[:id])
    render json: @game
  end
end
