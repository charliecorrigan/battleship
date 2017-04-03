require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_play_sequence'
require './lib/game_setup_sequence'
require 'pry'

class TestGamePlaySequence < Minitest::Test

  def test_it_exists
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    player_gameboard = game_setup_sequence.create_player_gameboard
    game_play_sequence = GamePlaySequence.new(player_gameboard, computer_gameboard)
    assert game_play_sequence
  end
end