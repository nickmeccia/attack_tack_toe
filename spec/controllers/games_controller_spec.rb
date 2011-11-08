require 'spec_helper'

describe GamesController do
  context "human_vs_computer" do
    it "creates a game with the human as the first player" do
      get :human_vs_computer, :player_one_color => "bzoramge"
    
      assigns[:game].player_one.should be_kind_of(Human)
      assigns[:game].player_one.team.should == "bzoramge"
    end
      
    it "creates a game with a Minimax as the second player" do
      get :human_vs_computer, :player_one_color => "cyan"
    
      assigns[:game].player_two.should be_kind_of(Minimax)
      assigns[:game].player_two.team.should == "red"
    end
    
    it "saves the game in the session" do
      get :human_vs_computer
      
      session[:game].should == assigns[:game]
    end
    
    it "renders the 'show' template" do
      get :human_vs_human
      
      response.should render_template("games/show")
    end
  end
  
  context "human_vs_human" do
    it "creates a game with humans as both players" do
      get :human_vs_human
      
      assigns[:game].player_one.should be_kind_of(Human)
      assigns[:game].player_two.should be_kind_of(Human)
    end

    it "saves the game in the session" do
      get :human_vs_human
      
      session[:game].should == assigns[:game]
    end
    
    it "renders the 'show' template" do
      get :human_vs_human
      
      response.should render_template("games/show")
    end
end
  
  context "make_move" do
    before(:each) do
      session[:game] = Game.new(Human.new("orange"), Human.new("cyan"))
      session[:images] = {}
    end
    
    it "moves in the first spot" do
      post :make_move, :row_number => "0", :column_number => "0"

      assigns[:game].board.get_cell(0).should == "orange"
    end
    
    it "moves in the second spot" do
      post :make_move, :row_number => "0", :column_number => "1"
      
      assigns[:game].board.get_cell(1).should == "orange"
    end

    it "moves in the center" do
      post :make_move, :row_number => "1", :column_number => "1"
      
      assigns[:game].board.get_cell(4).should == "orange"
    end
    
    it "uses the game in the session" do
      get :human_vs_computer
      session[:game].should_receive(:make_move).with(1)
    
      post :make_move, :row_number => "0", :column_number => "1"
    end
    
    it "makes a second move if the next player is a computer" do
      session[:game] = Game.new(Human.new("orange"), Minimax.new("cyan"))
      
      post :make_move, :row_number => "0", :column_number => "0"
      
      assigns[:game].board.remaining_moves.size.should == 7
    end
    
    it "does not make a second move if the next player is a human" do
      post :make_move, :row_number => "0", :column_number => "0"
      
      assigns[:game].board.remaining_moves.size.should == 8
    end
    
    context "session[:images]" do
      it "has an empty hash for session[:images] at human_vs_computer game initialization" do
        get :human_vs_computer
      
        session[:images].should be_empty
      end
      
      it "has an empty hash for session[:images] at human_vs_human game initialization" do
        get :human_vs_human
      
        session[:images].should be_empty
      end
      
      it "sets an orange glyph" do
        post :make_move, :row_number => "0", :column_number => "0"
        
        session[:images][0].should match("orange")
      end
      
      it "sets a cyan glyph for human" do
        post :make_move, :row_number => "0", :column_number => "0"
        post :make_move, :row_number => "0", :column_number => "1"
        
        session[:images][1].should match("cyan")
      end

      it "sets a cyan glyph for computer" do
        computer = Minimax.new("cyan")
        session[:game] = Game.new(Human.new("orange"), computer)
        post :make_move, :row_number => "0", :column_number => "0"
        
        session[:images][4].should match("cyan")
      end
    end
  end
end
