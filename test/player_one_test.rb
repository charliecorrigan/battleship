require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_one'
require './lib/game_setup_sequence'
require './lib/display_board'
require './lib/generate_new_gameboard'

class TestPlayerOne < Minitest::Test
  def test_it_exists
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    assert player_one
  end

  def test_access_to_unsunk_ship_attr
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    assert_equal [["a1", "a2"], ["b1", "b2", "b3"]], player_one.unsunk_ships
    player_one.unsunk_ships = ["b1", "b2", "b3"]
    assert_equal ["b1", "b2", "b3"], player_one.unsunk_ships
  end

  def test_get_valid_player_input_rejects_noncell_input
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    
    puts "**********TESTING NOTES***********"
    puts "Currently testing for user input validation."
    puts "Enter any cell name to continue or any non-cell name to test error handling."
    puts "**********************************"
    player_guess = player_one.get_valid_player_input(computer_gameboard)
    assert player_guess
  end

  def test_get_valid_player_input_rejects_already_guessed_coordinate
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    
    puts "**********TESTING NOTES***********"
    puts "Currently testing for user input validation."
    puts "'b2' has been set to 'fired_on = true' and should not be valid."
    puts "Enter any cell name other than 'b2' to continue or 'b2' to test error handling."
    puts "**********************************"
    computer_gameboard[1]["b2"].fired_on = true
    player_guess = player_one.get_valid_player_input(computer_gameboard)
    assert player_guess
    assert_equal Cell, player_guess.class
  end

  def test_solicit_player_guess_returns_string
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    puts "**********TESTING NOTES***********"
    puts "Currently testing for user input class."
    puts "Enter coordinate to continue."
    puts "**********************************"
    player_guess = player_one.solicit_player_guess
    assert_equal String, player_guess.class
  end

  def test_is_guess_valid
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    
    player_guess = "A1"
    valid = player_one.is_guess_valid?(player_guess, computer_gameboard)
    assert valid

    player_guess = "?"
    valid = player_one.is_guess_valid?(player_guess, computer_gameboard)
    refute valid

    player_guess = ""
    valid = player_one.is_guess_valid?(player_guess, computer_gameboard)
    refute valid
  end

  def test_calculate_result
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    computer_gameboard[3]["d4"].ship = true
    player_guess = computer_gameboard[3]["d4"]
    result = player_one.calculate_result(player_guess)
    assert_equal "hit", result

    computer_gameboard[3]["d4"].ship = false
    player_guess = computer_gameboard[3]["d4"]
    result = player_one.calculate_result(player_guess)
    assert_equal "miss", result
  end

  def test_cell_method_translates_cell_name_to_cell_instance
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    cell_name = "a2"
    result = player_one.cell(computer_gameboard, cell_name)
    assert_equal Cell, result.class
  end

  def test_puts_display_results
    computer_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    result = "miss"
    puts_statement = player_one.display_result(result)
    assert_nil puts_statement
  end

  def test_list_possible_keys
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    possible_keys = player_one.list_possible_keys(computer_gameboard)
    assert_equal ["a1", "a2", "a3", "a4", "b1", "b2", "b3", "b4", "c1", "c2", "c3", "c4", "d1", "d2", "d3", "d4"], possible_keys
  end

  def test_create_cell_references_in_fleet
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["d3", "d4"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    smart_fleet = player_one.create_cell_references_in_fleet(computer_fleet, computer_gameboard)
    assert_equal computer_fleet.length, smart_fleet.length
    assert_equal computer_fleet[0][0], smart_fleet[0][0].name
  end

  def test_check_if_ship_is_sunk
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_gameboard[0]["a1"].ship = true
    computer_gameboard[0]["a2"].ship = true
    computer_gameboard[1]["b1"].ship = true
    computer_gameboard[1]["b2"].ship = true
    computer_gameboard[1]["b3"].ship = true
    computer_gameboard[0]["a1"].turn_result = "hit"
    computer_gameboard[0]["a2"].turn_result = "hit"
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    sunk = player_one.check_if_ship_is_sunk(computer_fleet, computer_gameboard)
    assert sunk
  end

  def test_check_if_fleet_is_sunk
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    unsunk_ships = player_one.unsunk_ships
    refute player_one.check_if_fleet_is_sunk(unsunk_ships)
    player_one.unsunk_ships = []
    refute player_one.check_if_fleet_is_sunk(unsunk_ships)
  end

  def test_check_if_fleet_is_sunk_the_hard_way
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_gameboard[0]["a1"].ship = true
    computer_gameboard[0]["a2"].ship = true
    computer_gameboard[1]["b1"].ship = true
    computer_gameboard[1]["b2"].ship = true
    computer_gameboard[1]["b3"].ship = true
    computer_gameboard[0]["a1"].turn_result = "hit"
    computer_gameboard[0]["a2"].turn_result = "hit"
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    unsunk_ships = player_one.unsunk_ships
    player_one.check_if_ship_is_sunk(unsunk_ships, computer_gameboard)
    refute player_one.check_if_fleet_is_sunk(unsunk_ships)
    computer_gameboard[1]["b1"].turn_result = "hit"
    computer_gameboard[1]["b2"].turn_result = "hit"
    computer_gameboard[1]["b3"].turn_result = "hit"
    player_one.check_if_ship_is_sunk(unsunk_ships, computer_gameboard)
    assert player_one.check_if_fleet_is_sunk(unsunk_ships)
  end

  def test_player_takes_a_turn
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    computer_fleet = new_setup.computer_fleet
    player_one = PlayerOne.new(computer_fleet)
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    puts "**********TESTING NOTES*************************"
    puts "Currently testing #player_takes_a_turn sequence."
    puts "Enter a coordinate to continue."
    puts "************************************************"
    player_one.player_takes_a_turn(computer_gameboard, player_one_display_board)
    counter = 0
    computer_gameboard.each do |row|
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
