require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'
require './lib/game_setup_sequence'
require './lib/display_board'

class TestComputer < Minitest::Test

  def test_it_exists
    player_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    assert computer
  end

  def test_select_random_available_square
    new_player_gameboard = GenerateNewGameboard.new(4)
    player_gameboard = new_player_gameboard.generate_blank_gameboard
    new_player_gameboard.link_gameboard_cells(player_gameboard)
    player_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    computer_guess = computer.select_random_available_square(player_gameboard)
    assert_instance_of Cell, computer_guess
    player_gameboard[0]["a1"].fired_on = true
    player_gameboard[0]["a2"].fired_on = true
    player_gameboard[0]["a3"].fired_on = true
    player_gameboard[0]["a4"].fired_on = true
    player_gameboard[1]["b1"].fired_on = true
    player_gameboard[1]["b2"].fired_on = true
    player_gameboard[1]["b3"].fired_on = true
    player_gameboard[1]["b4"].fired_on = true
    player_gameboard[2]["c1"].fired_on = true
    player_gameboard[2]["c2"].fired_on = true
    player_gameboard[2]["c3"].fired_on = true
    player_gameboard[2]["c4"].fired_on = true
    player_gameboard[3]["d1"].fired_on = true
    player_gameboard[3]["d2"].fired_on = true
    player_gameboard[3]["d3"].fired_on = true
    computer_guess = computer.select_random_available_square(player_gameboard)
    assert_equal "d4", computer_guess.name
  end

  def test_calculate_result
    new_player_gameboard = GenerateNewGameboard.new(4)
    player_gameboard = new_player_gameboard.generate_blank_gameboard
    new_player_gameboard.link_gameboard_cells(player_gameboard)
    player_gameboard[3]["d4"].ship = true
    player_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    computer_guess = player_gameboard[3]["d4"]
    result = computer.calculate_result(computer_guess)
    assert_equal "hit", result

    player_gameboard[3]["d4"].ship = false
    computer_guess = player_gameboard[3]["d4"]
    result = computer.calculate_result(computer_guess)
    assert_equal "miss", result
  end

  def test_create_cell_references_in_fleet
    new_player_gameboard = GenerateNewGameboard.new(4)
    player_gameboard = new_player_gameboard.generate_blank_gameboard
    new_player_gameboard.link_gameboard_cells(player_gameboard)
    player_gameboard[0]["a1"].ship = true
    player_gameboard[0]["a2"].ship = true
    player_gameboard[1]["b1"].ship = true
    player_gameboard[1]["b2"].ship = true
    player_gameboard[1]["b3"].ship = true
    player_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    smart_fleet = computer.create_cell_references_in_fleet(player_fleet, player_gameboard)
    assert_equal Array, smart_fleet.class
    assert_equal 2, smart_fleet.length
    assert_equal 3, smart_fleet.last.length
    assert_equal Cell, smart_fleet.first.first.class
  end

  def test_check_if_ship_is_sunk
    new_player_gameboard = GenerateNewGameboard.new(4)
    player_gameboard = new_player_gameboard.generate_blank_gameboard
    new_player_gameboard.link_gameboard_cells(player_gameboard)
    player_gameboard[0]["a1"].ship = true
    player_gameboard[0]["a2"].ship = true
    player_gameboard[1]["b1"].ship = true
    player_gameboard[1]["b2"].ship = true
    player_gameboard[1]["b3"].ship = true
    player_gameboard[0]["a1"].turn_result = "hit"
    player_gameboard[0]["a2"].turn_result = "hit"
    player_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    sunk = computer.check_if_ship_is_sunk(player_fleet, player_gameboard)
    assert sunk
  end

  def test_check_if_fleet_is_sunk
    player_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    computer = Computer.new(player_fleet)
    unsunk_ships = computer.unsunk_ships
    refute computer.check_if_fleet_is_sunk(unsunk_ships)
    computer.unsunk_ships = []
    refute computer.check_if_fleet_is_sunk(unsunk_ships)
  end

  def test_computer_takes_a_turn
    new_setup = GameSetupSequence.new("beginner")
    player_gameboard = new_setup.create_player_gameboard
    player_fleet = new_setup.player_fleet
    computer_display_board = DisplayBoard.new(player_gameboard)
    computer = Computer.new(player_fleet)
    computer.computer_takes_a_turn(player_gameboard, computer_display_board)
    counter = 0
    player_gameboard.each do |row|
      row.each do |cell|
        if cell[1].fired_on == true
          puts cell[1].name
          counter += 1
        end
      end
    end
    assert_equal 1, counter
  end
end