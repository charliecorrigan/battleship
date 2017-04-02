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

  def test_find_next_cell_points_in_direction_given
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    assert_equal blank_gameboard[0]["a2"], ship_placement.find_next_cell(blank_gameboard[0]["a1"], "right")
  end

  def test_find_valid_random_direction_output
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    first_coordinate = blank_gameboard[0]["a1"]
    ship_size = 3
    ship_coordinates = ship_placement.find_valid_random_direction(first_coordinate, ship_size)
    assert_equal 3, ship_coordinates.length
    assert_equal Cell, ship_coordinates.first.class
  end

  def test_computer_selects_ship_placement
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    size = new_gameboard.size
    ship_placement = ShipPlacement.new([2, 3])
    ship_size = 2
    ship_coordinates = ship_placement.computer_selects_ship_placement(blank_gameboard, size, ship_size)
    assert_instance_of Array, ship_coordinates
    assert_equal ship_size, ship_coordinates.length
    assert_instance_of Cell, ship_coordinates.first
    assert_instance_of Cell, ship_coordinates.last
  end

  def test_place_ship_on_board
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    size = new_gameboard.size
    ship_placement = ShipPlacement.new([2, 3])
    ship_size = 2
    ship_coordinates = ship_placement.computer_selects_ship_placement(blank_gameboard, size, ship_size)
    ship_placement.place_ship_on_board(ship_coordinates)
    assert ship_coordinates.first.ship
    assert ship_coordinates.last.ship
  end

  def test_if_place_ship_on_board_changes_correct_number_of_attributes
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    size = new_gameboard.size
    ship_placement = ShipPlacement.new([2, 3])
    ships_in_play = [2, 3]
    ships_in_play.each do |this_ship|
      ship_coordinates = ship_placement.computer_selects_ship_placement(blank_gameboard, size, this_ship)
      ship_placement.place_ship_on_board(ship_coordinates)
    end
    counter = 0
    blank_gameboard.each do |row|
      row.each do |cell|
        if cell[1].ship == true
          counter += 1
        end
      end
    end
    assert_equal 5, counter
  end
end