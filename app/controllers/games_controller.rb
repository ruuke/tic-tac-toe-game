class GamesController < ApplicationController
  def new
    @player = Player.find(params[:player_id])
    @game = Game.where(status: 'waiting_for_player').first

    if @game
      @game.update(player_o: @player, status: 'in_progress')
    else
      @game = Game.create(player_x: @player, current_turn: 'X', status: 'waiting_for_player')
    end

    redirect_to game_path(@game)
  end

  def create
    player_x = Player.find(params[:game][:player_x_id])
    @game = Game.create!(player_x: player_x, current_turn: 'X', status: 'waiting_for_player')
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def join
    @game = Game.find(params[:id])
    player_o = Player.find(params[:player_o_id])
    if @game.status == 'waiting_for_player'
      @game.update!(player_o: player_o, status: 'in_progress')
    end
    render json: @game
  end
end
