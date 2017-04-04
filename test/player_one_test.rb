require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_one'
require './lib/game_setup_sequence'
require './lib/display_board'
require './lib/generate_new_gameboard'
require './lib/game_play_sequence'
require 'pry'

class TestPlayerOne < Minitest::Test
  def test_it_exists
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    assert player_one
  end

  def test_get_valid_player_input_rejects_noncell_input
    skip
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    
    puts "**********TESTING NOTES***********"
    puts "Currently testing for user input validation."
    puts "Enter any cell name to continue or any non-cell name to test error handling."
    player_guess = player_one.get_valid_player_input(computer_gameboard)
    assert player_guess
  end

  def test_get_valid_player_input_rejects_already_guessed_coordinate
    skip
    new_computer_gameboard = GenerateNewGameboard.new(4)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    
    puts "**********TESTING NOTES***********"
    puts "Currently testing for user input validation."
    puts "'b2' has been set to 'fired_on = true' and should not be valid."
    puts "Enter any cell name other than 'b2' to continue or 'b2' to test error handling."
    computer_gameboard[1]["b2"].fired_on = true
    player_guess = player_one.get_valid_player_input(computer_gameboard)
    assert player_guess
    assert_equal Cell, player_guess.class
  end

  def test_solicit_player_guess_returns_string
    computer_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
    player_one = PlayerOne.new(computer_fleet)
    player_guess = player_one.solicit_player_guess
    assert_equal String, player_guess.class
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

  # def test_player_takes_a_turn
  #   skip
  #   new_setup = GameSetupSequence.new("beginner")
  #   computer_gameboard = new_setup.create_computer_gameboard
  #   computer_fleet = new_setup.computer_fleet
  #   player_one_display_board = DisplayBoard.new(computer_gameboard)
  #   player_one = PlayerOne.new
  #   unsunk_ships = computer_fleet
  #   player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, unsunk_ships)
    
  #   counter = 0
  #   computer_gameboard.each do |row|
  #     row.each do |cell|
  #       if cell[1].fired_on == true
  #         puts cell[1].name
  #         counter += 1
  #       end
  #     end
  #   end
  #   assert_equal 1, counter

  #   player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, unsunk_ships)
  #   counter = 0
  #   computer_gameboard.each do |row|
  #     row.each do |cell|
  #       if cell[1].fired_on == true
  #         puts cell[1].name
  #         counter += 1
  #       end
  #     end
  #   end
  #   assert_equal 2, counter

  #   player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, unsunk_ships)
  #   counter = 0
  #   computer_gameboard.each do |row|
  #     row.each do |cell|
  #       if cell[1].fired_on == true
  #         puts cell[1].name
  #         counter += 1
  #       end
  #     end
  #   end
  #   assert_equal 3, counter
  # end





  

  def test_calculate_result_return
    skip
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    player_one = PlayerOne.new

    computer_gameboard[0]["a2"].ship = true
    result = player_one.calculate_result(computer_gameboard, "A2")
    assert_equal "hit", result

    computer_gameboard[3]["d2"].ship = false
    result = player_one.calculate_result(computer_gameboard, "D2")
    assert_equal "miss", result
  end
  
  # 
  #   new_setup = GameSetupSequence.new("beginner")
  #   computer_gameboard = new_setup.create_computer_gameboard
  #   computer_gameboard[0]["a2"].ship = true
  #   computer_gameboard[0]["a2"].fired_on = true
  #   computer_gameboard[0]["a2"].turn_result = "hit"
  #   computer_fleet = new_setup.computer_fleet
  #   player_one_display_board = DisplayBoard.new(computer_gameboard)
  #   player_one = PlayerOne.new
  #   winner = player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, computer_fleet)
  #   assert_nil winner
  # end

  # def test_if_check_on_fleet_recognizes_sunk_ship
  #   new_computer_gameboard = GenerateNewGameboard.new(4)
  #   computer_gameboard = new_computer_gameboard.generate_blank_gameboard
  #   new_computer_gameboard.link_gameboard_cells(computer_gameboard)
  #   computer_fleet = [[computer_gameboard[0]["a1"], computer_gameboard[0]["a2"]], [computer_gameboard[1]["b1"], computer_gameboard[1]["b2"], computer_gameboard[1]["b3"]]]
  #   computer_gameboard[0]["a1"].ship = true 
  #   computer_gameboard[0]["a2"].ship = true
  #   computer_gameboard[1]["b1"].ship = true
  #   computer_gameboard[1]["b2"].ship = true 
  #   computer_gameboard[1]["b3"].ship = true
  #   player_one = PlayerOne.new
  #   computer_gameboard[0]["a1"].fired_on = true
  #   computer_gameboard[0]["a1"].turn_result = "hit"
  #   computer_gameboard[0]["a2"].fired_on = true
  #   computer_gameboard[0]["a2"].turn_result = "hit"
  #   name_only_fleet = [["a1", "a2"], ["b1", "b2", "b3"]]
  #   winner = player_one.check_on_fleet(name_only_fleet, computer_gameboard)
  #   assert_nil winner

  #   computer_gameboard[1]["b1"].fired_on = true
  #   computer_gameboard[1]["b1"].turn_result = "hit"
  #   computer_gameboard[1]["b2"].fired_on = true
  #   computer_gameboard[1]["b2"].turn_result = "hit"
  #   computer_gameboard[1]["b3"].fired_on = true
  #   computer_gameboard[1]["b3"].turn_result = "hit"
  #   winner = player_one.check_on_fleet(name_only_fleet, computer_gameboard)
  #   assert winner
  # end

  end
