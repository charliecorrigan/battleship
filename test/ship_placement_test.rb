require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship_placement'
require './lib/generate_new_gameboard'
require 'pry'


class TestShipPlacement < Minitest::Test

  def test_it_exists
    ship_placement = ShipPlacement.new([2, 3])
    assert ship_placement
  end

  def test_select_random_coordinate
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    size = new_gameboard.size
    ship_placement = ShipPlacement.new([2, 3])
    random_coordinate = ship_placement.select_random_coordinate(blank_gameboard, size)
    
    assert_equal Cell, random_coordinate.class
    assert_equal false, random_coordinate.ship
  end

  def test_select_random_direction_output
    ship_placement = ShipPlacement.new([2, 3])
    output = ship_placement.select_random_direction
    assert_instance_of String, output
    assert output == "up" || output == "down" || output == "right" || output == "left"
      
  end
end