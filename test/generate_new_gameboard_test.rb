require 'minitest/autorun'
require 'minitest/pride'
require './lib/generate_new_gameboard'

class TestGenerateNewGameboard < Minitest::Test

  def test_if_it_exists
    new_gameboard = GenerateNewGameboard.new(4)
    assert new_gameboard
  end

  def test_size_attribute_is_accessible
    new_gameboard = GenerateNewGameboard.new(4)
    assert_equal 4, new_gameboard.size
  end

  def test_initialize_empty_gameboard_spaces_return_values
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.initialize_empty_gameboard_spaces(4)
    assert_equal Array, blank_gameboard.class
    assert_equal 4, blank_gameboard.length
    assert_equal Array, blank_gameboard.first.class
    assert_equal 4, blank_gameboard.first.length
  end
end