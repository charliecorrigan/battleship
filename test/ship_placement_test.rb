require 'simplecov'
SimpleCov.start
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

  def test_show_ship_placement_instructions
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    message = ship_placement.show_ship_placement_instructions("beginner")
    expected_message = "I have laid out my ships on the grid.\nYou now need to layout your  ships.\nThe first is two units long and the\nsecond is three units long.\nThe grid has A1 at the top left and D4 at the bottom right."
    assert_equal expected_message, message
  end

  def test_player_selects_ship_placement_return_values
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    ship_size = 2
    ship_coordinates = ship_placement.player_selects_ship_placement(blank_gameboard, ship_size)
    assert_instance_of Array, ship_coordinates
    assert_equal ship_size, ship_coordinates.length
    assert_instance_of Cell, ship_coordinates.first
    assert_instance_of Cell, ship_coordinates.last
  end

  def test_solicit_user_input_return_values
    skip
    ship_placement = ShipPlacement.new([2, 3])
    ship_size = 2
    user_input = ship_placement.solicit_user_input(ship_size)
    assert_equal String, user_input.class
  end

  def test_user_input_contains_cell_names
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    possible_keys = ship_placement.list_possible_keys(blank_gameboard)
    user_input = "A2 A3"
    assert ship_placement.user_input_contains_cell_names(user_input, possible_keys)
    user_input = "A2!"
    refute ship_placement.user_input_contains_cell_names(user_input, possible_keys)
  end

  def test_validate_player_coordinates
    new_gameboard = GenerateNewGameboard.new(4)
    blank_gameboard = new_gameboard.generate_blank_gameboard
    new_gameboard.link_gameboard_cells(blank_gameboard)
    ship_placement = ShipPlacement.new([2, 3])
    ship_size = 2
    player_input = "C1 D1"
    ship_coordinates = ship_placement.validate_player_coordinates(blank_gameboard, player_input, ship_size)
    assert_equal blank_gameboard[2]["c1"], ship_coordinates.first
    assert_equal blank_gameboard[3]["d1"], ship_coordinates.last

    ship_size = 3
    player_input = "A4 A2"
    ship_coordinates = ship_placement.validate_player_coordinates(blank_gameboard, player_input, ship_size)
    assert_equal blank_gameboard[0]["a4"], ship_coordinates.first
    assert_equal blank_gameboard[0]["a2"], ship_coordinates.last

    ship_size = 3
    player_input = "A4 C2"
    ship_coordinates = ship_placement.validate_player_coordinates(blank_gameboard, player_input, ship_size)
    assert_nil ship_coordinates
  end

  def test_player_input_rows
    ship_placement = ShipPlacement.new([2, 3])
    rows = ship_placement.player_input_rows(["a1", "b1"])
    assert_equal ["a", "b"], rows
  end

  def test_player_input_columns
    ship_placement = ShipPlacement.new([2, 3])
    columns = ship_placement.player_input_columns(["a1", "b1"])
    assert_equal ["1", "1"], columns
  end

  def test_player_input_rows_as_numbers
    ship_placement = ShipPlacement.new([2, 3])
    row_nums = ship_placement.player_input_rows_as_numbers(["a", "b"])
    assert_equal [1, 2], row_nums
  end
end