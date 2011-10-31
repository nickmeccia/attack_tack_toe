class GamesController < ApplicationController

  def human_vs_computer
    @game = Game.new(Human.new("x"), Minimax.new("o"))
    session[:game] = @game
  end
  
  def make_move
    @game = session[:game]
    @game.make_move(position)
    @game.take_next_turn if @game.current_player.computer?
    render :action => "human_vs_computer"
  end

  private
  
  def position
    params[:column_number].to_i + params[:row_number].to_i * 3
  end
end
