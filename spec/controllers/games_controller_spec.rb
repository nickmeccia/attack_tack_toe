require 'spec_helper'

describe GamesController do
  context "human_vs_computer" do
    it "creates a game with the human as the first player" do
      get :human_vs_computer
    
      assigns[:game].player_one.should be_kind_of(Human)
      assigns[:game].player_one.team.should == "x"
    end
      
    it "creates a game with a Minimax as the second player" do
      get :human_vs_computer
    
      assigns[:game].player_two.should be_kind_of(Minimax)
      assigns[:game].player_two.team.should == "o"
    end
    
    it "saves the game in the session" do
      get :human_vs_computer
      
      session[:game].should == assigns[:game]
    end
  end
  
  context "make_move" do
    before(:each) do
      session[:game] = Game.new(Human.new("x"), Human.new("x"))
    end
    
    it "moves in the first spot" do
      post :make_move, :row_number => "0", :column_number => "0"

      assigns[:game].board.get_cell(0).should == "x"
    end
    
    it "moves in the second spot" do
      post :make_move, :row_number => "0", :column_number => "1"
      
      assigns[:game].board.get_cell(1).should == "x"
    end

    it "moves in the center" do
      post :make_move, :row_number => "1", :column_number => "1"
      
      assigns[:game].board.get_cell(4).should == "x"
    end
    
    it "uses the game in the session" do
      get :human_vs_computer
      session[:game].should_receive(:make_move).with(1)
    
      post :make_move, :row_number => "0", :column_number => "1"
    end
    
    it "makes a second move if the next player is a computer" do
      session[:game] = Game.new(Human.new("x"), Minimax.new("o"))
      
      post :make_move, :row_number => "0", :column_number => "0"
      
      assigns[:game].board.remaining_moves.size.should == 7
    end
    
    it "does not make a second move if the next player is a human" do
      post :make_move, :row_number => "0", :column_number => "0"
      
      assigns[:game].board.remaining_moves.size.should == 8
    end
  end
end
