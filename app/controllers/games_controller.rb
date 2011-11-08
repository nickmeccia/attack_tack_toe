class GamesController < ApplicationController


  def human_vs_computer
    @game = Game.new(Human.new(params[:player_one_color]), Minimax.new("red"))
    session[:game] = @game
    session[:images] = {}
    render :action => "show"
  end

  def human_vs_human
    @game = Game.new(Human.new("orange"), Human.new("cyan"))
    session[:game] = @game
    session[:images] = {}
    render :action => "show"
  end
  
  def make_move
    @game = session[:game]
    session[:images][position] = "#{@game.current_player.team}-#{random_number}.png"
    @game.make_move(position)
    if @game.current_player.computer?
      computer_move = @game.current_player.move_for(@game.board)
      session[:images][computer_move] = "#{@game.current_player.team}-#{random_number}.png"
      @game.make_move(computer_move)
    end
    @images = session[:images]
    render :action => "show"
  end
  

  private

  def position
    params[:column_number].to_i + params[:row_number].to_i * 3
  end

  def random_number
    rand(7)
  end
end
