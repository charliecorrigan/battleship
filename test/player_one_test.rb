require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_one'
require './lib/game_setup_sequence'

class TestPlayerOne < Minitest::Test
  def test_it_exists
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one = PlayerOne.new
    assert player_one
  end

  def test_player_takes_a_turn
    #runner_method
  end
end
