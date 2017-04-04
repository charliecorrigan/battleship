require 'minitest/autorun'
require 'minitest/pride'
require './lib/play_battleship'


class TestPlayBattleship < Minitest::Test

  def test_it_exists
    play = PlayBattleship.new
    assert play
  end

  def test_get_time_stamp_saves_time
    play = PlayBattleship.new
    start_time = play.get_time_stamp
    assert start_time
    assert_equal String, start_time.class
  end

  def test_run_game_sequences_method_runs_when_initialized
    play = PlayBattleship.new
    assert play.run_game_sequences
  end

  def test_access_to_fleet
    play = PlayBattleship.new
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    computer_fleet = game_setup_sequence.computer_fleet
    assert_equal Array, computer_fleet.class
    assert_equal 2, computer_fleet[0].length
  end
end