require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_play_sequence'
require './lib/game_setup_sequence'
require 'pry'

class TestGamePlaySequence < Minitest::Test

  def test_it_exists
    skip
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    player_gameboard = game_setup_sequence.create_player_gameboard
    game_play_sequence = GamePlaySequence.new(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    assert game_play_sequence
  end

  def test_take_turns_playing
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    computer_fleet = game_setup_sequence.computer_fleet
    player_gameboard = game_setup_sequence.create_player_gameboard
    player_fleet = game_setup_sequence.player_fleet
    won = game_play_sequence = GamePlaySequence.new(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    result = "player"
    assert_equal result, won
  end
end