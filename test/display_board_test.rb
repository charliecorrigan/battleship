require 'minitest/autorun'
require 'minitest/pride'
require './lib/display_board'
require './lib/game_setup_sequence'

class TestDisplayBoard < Minitest::Test

  def test_it_exists
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    assert player_one_display_board
  end

  def test_it_generates_a_blank_display_board_when_initialized
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    assert_equal ["==========", ". 1 2 3 4 ", "A         ", "B         ", "C         ", "D         ", "=========="], player_one_display_board.current_board
    assert_equal Array, player_one_display_board.current_board.class
    assert_equal 7, player_one_display_board.current_board.length

  end

  def test_that_update_method_effects_current_board_predictably
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    player_one_display_board.update("b3", "miss")
    assert_equal ["==========", ". 1 2 3 4 ", "A         ", "B     M   ", "C         ", "D         ", "=========="], player_one_display_board.current_board
  end

  # def test_display_method_prints
  #   #Not sure how to test this yet.
  # end


end