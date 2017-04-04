require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_one'
require './lib/game_setup_sequence'
require './lib/display_board'

class TestPlayerOne < Minitest::Test
  def test_it_exists
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one = PlayerOne.new
    assert player_one
  end

  def test_player_takes_a_turn
    skip
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    player_one = PlayerOne.new
    player_one.player_takes_a_turn(computer_gameboard, player_one_display_board)
  end

  def test_solicit_player_guess_returns_string
    skip
    player_one = PlayerOne.new
    player_guess = player_one.solicit_player_guess
    assert_equal String, player_guess.class
  end

  def test_is_guess_valid
    skip
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one = PlayerOne.new
    valid = player_one.is_guess_valid?("A1", computer_gameboard)
    assert valid
    valid = player_one.is_guess_valid?("R1", computer_gameboard)
    refute valid
    computer_gameboard[0]["a2"].fired_on = true
    valid = player_one.is_guess_valid?("A2", computer_gameboard)
    refute valid
  end

  def test_get_valid_player_input
    
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one = PlayerOne.new
    player_guess = player_one.get_valid_player_input(computer_gameboard)
    assert player_guess
  end

end
