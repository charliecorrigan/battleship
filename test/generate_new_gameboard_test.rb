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
    empty_gameboard = new_gameboard.initialize_empty_gameboard_spaces
    assert_equal Array, empty_gameboard.class
    assert_equal 4, empty_gameboard.length
    assert_equal Array, empty_gameboard.first.class
    assert_equal 4, empty_gameboard.first.length
  end

  def test_generate_blank_gameboard_return_values
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    assert_equal Array, blank_gameboard.class
    assert_equal 4, blank_gameboard.length
    assert_equal Hash, blank_gameboard.first.class
    assert_equal 4, blank_gameboard.first.length
    assert_equal ["a1", "a2", "a3", "a4"], blank_gameboard[0].keys
    refute blank_gameboard[0]["a1"].ship
  end

  def test_ability_to_change_cell_properties
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    refute blank_gameboard[0]["a1"].ship
    blank_gameboard[0]["a1"].ship = true
    assert blank_gameboard[0]["a1"].ship
  end

  def test_assign_all_up_attributes
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.assign_all_up_attributes(blank_gameboard, ["a", "b", "c", "d"])
    assert_nil blank_gameboard[0]["a1"].up
    assert_equal blank_gameboard[0]["a2"], blank_gameboard[1]["b2"].up
    assert_equal blank_gameboard[2]["c4"], blank_gameboard[3]["d4"].up
  end

  def test_assign_all_down_attributes
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.assign_all_down_attributes(blank_gameboard, ["a", "b", "c", "d"])
    assert_nil blank_gameboard[3]["d1"].down
    assert_equal blank_gameboard[2]["c2"], blank_gameboard[1]["b2"].down
    assert_equal blank_gameboard[1]["b4"], blank_gameboard[0]["a4"].down
  end

  # def test_link_gameboard_cells_efficacy
  #   new_gameboard = GenerateNewGameboard.new(4)
  #   blank_gameboard = new_gameboard.generate_blank_gameboard
  #   connected_gameboard = new_gameboard.link_gameboard_cells(blank_gameboard)
    
  #   assert_nil blank_gameboard[0]["a1"].up
  #   assert_equal blank_gameboard[1]["b1"], blank_gameboard[0]["a1"].down
  #   assert_nil blank_gameboard[0]["a1"].left
  #   assert_equal blank_gameboard[0]["a2"], blank_gameboard[0]["a1"].right

  #   assert_equal blank_gameboard[0]["a2"], blank_gameboard[1]["b2"].up
  #   assert_equal blank_gameboard[2]["c2"], blank_gameboard[1]["b2"].down
  #   #assert_equal blank_gameboard[1]["b1"], blank_gameboard[1]["b2"].left
  #   binding.pry
  #   assert_equal blank_gameboard[1]["b3"], blank_gameboard[1]["b2"].right
  # end
end