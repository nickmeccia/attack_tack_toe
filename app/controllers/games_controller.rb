class GamesController < ApplicationController

  def human_vs_computer
    @game = Game.new(Human.new("x"), Minimax.new("o"))
    session[:game] = @game
    render :action => "show"
  end

  def human_vs_human
    @game = Game.new(Human.new("x"), Human.new("o"))
    session[:game] = @game
    render :action => "show"
  end
  
  def make_move
    @game = session[:game]
    @game.make_move(position)
    @game.take_next_turn if @game.current_player.computer?
    render :action => "show"
  end

  private
  
  def position
    params[:column_number].to_i + params[:row_number].to_i * 3
  end
end
