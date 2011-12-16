module GamesHelper
  def position(column_number, row_number)
    column_number.to_i + row_number.to_i * 3
  end
  
  def game_over_image(game)
    if game.draw?
      return "draw.png"
    elsif has_computer_player?(game)
      human_vs_computer_game_over_image(game)
    else
      human_vs_human_game_over_image(game)
    end
  end
  
  def human_vs_computer_game_over_image(game)
    if game.winner.computer?
      return "you_lose.png"
    else
      return "you_win.png"
    end
  end
  
  def human_vs_human_game_over_image(game)
    if game.winner == game.player_one
      return "p1_wins.png"
    else
      return "p2_wins.png"
    end
  end

  def has_computer_player?(game)
    game.player_one.computer? || game.player_two.computer?
  end
end
