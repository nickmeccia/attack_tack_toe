Feature: Playing a game
  In order to have some fun
  As a user
  I want to play Nick Tac Toe

  Scenario: Starting a new game
		Given I go to the homepage
		When I follow "1 Player"
		Then the game should be started
