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
    assert_equal "cat", random_coordinate.name

    random_coordinate = ship_placement.select_random_coordinate(blank_gameboard, size)
    assert_equal "cat", random_coordinate.name
  end

  # def test_place_ships
  #   new_gameboard = GenerateNewGameboard.new(4)
  #   blank_gameboard = new_gameboard.generate_blank_gameboard
  #   new_gameboard.link_gameboard_cells(blank_gameboard)
  #   size = new_gameboard.size
  #   ship_placement = ShipPlacement.new([3, 2])
  #   ship_placement.place_ships(blank_gameboard, [3, 2], size)
  #   counter = 0
  #   locations = []
  #   blank_gameboard.each do |row|
  #     row.each do |cell|
  #       if cell[1].ship == true
  #         counter +=1
  #         locations << cell[1].name
  #       end
  #     end
  #   end
  #   assert_equal 5, counter
  #   assert_equal ["cat"], locations
  # end
  # def test_select_random_direction_return
  #   ship_placement = ShipPlacement.new([2, 3])
  #   new_gameboard = GenerateNewGameboard.new(4)
  #   blank_gameboard = new_gameboard.generate_blank_gameboard
  #   new_gameboard.link_gameboard_cells(blank_gameboard)
  #   current_coordinate = blank_gameboard[0]["a1"]
  #   next_cell_over = ship_placement.select_random_direction(current_coordinate)
  #   unless next_cell_over.nil?
  #     assert_equal String, next_cell_over.name.class
  #     assert_equal 2, next_cell_over.name.length
  #   end
    #end    


# Ships cannot wrap around the board
# Ships cannot overlap
# Ships can be laid either horizontally or vertically
# Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)
end