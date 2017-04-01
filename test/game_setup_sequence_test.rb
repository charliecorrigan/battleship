require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_setup_sequence'


class TestGameSetupSequence < Minitest::Test
  
  def test_it_exists
    new_setup = GameSetupSequence.new
    assert new_setup
  end

  def test_it_initializes_with_beginner_as_difficulty_by_default
    new_setup = GameSetupSequence.new
    assert_equal "beginner", new_setup.difficulty
  end

  def test_difficulty_can_be_specified_and_changed_on_initialization
    new_setup = GameSetupSequence.new("beginner")
    assert_equal "beginner", new_setup.difficulty
    new_setup = GameSetupSequence.new("intermediate")
    assert_equal "intermediate", new_setup.difficulty
    new_setup = GameSetupSequence.new("advanced")
    assert_equal "advanced", new_setup.difficulty
  end

  
end