require 'spec_helper'

describe GamesHelper do
  context "human vs computer game" do
    before(:each) do
      @human = mock("player", :computer? => false)
      @computer = mock("computer", :computer? => true)
      @game = mock("game", :player_one => @human, :player_two => @computer, :draw? => false)
    end

    it "displays the correct message if the human wins" do
      @game.stub!(:winner).and_return(@human)
      game_over_image(@game).should == "you_win.png"
    end
    
    it "displays the correct message if the computer wins" do
      @game.stub!(:winner).and_return(@computer)
      game_over_image(@game).should == "you_lose.png"
    end
    
    it "has a draw banner" do
      @game.stub!(:draw?).and_return(true)
      game_over_image(@game).should == "draw.png"
    end
  end

  context "computer vs human game" do
    before(:each) do
      @human = mock("player", :computer? => false)
      @computer = mock("computer", :computer? => true)
      @game = mock("game", :player_one => @computer, :player_two => @human, :draw? => false)
    end

    it "displays the correct message if the human wins" do
      @game.stub!(:winner).and_return(@human)
      game_over_image(@game).should == "you_win.png"
    end
    
    it "displays the correct message if the computer wins" do
      @game.stub!(:winner).and_return(@computer)
      game_over_image(@game).should == "you_lose.png"
    end
  end

  context "human vs human game" do
    before(:each) do
      @player_one = mock("player", :computer? => false)
      @player_two = mock("player", :computer? => false)
      @game = mock("game", :player_one => @player_one, :player_two => @player_two, :draw? => false)
    end
    
    it "displays the correct message if player one wins" do
      @game.stub!(:winner).and_return(@player_one)
      game_over_image(@game).should == "p1_wins.png"
    end
    
    it "displays the correct message if player two wins" do
      @game.stub!(:winner).and_return(@player_two)
      game_over_image(@game).should == "p2_wins.png"      
    end
  end

end
