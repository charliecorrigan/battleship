require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'
require './lib/game_setup_sequence'
require './lib/display_board'

class TestComputer < Minitest::Test

  def test_it_exists
    computer = Computer.new
    assert computer
  end

  def test_select_random_available_square
    skip
    new_setup = GameSetupSequence.new("beginner")
    player_gameboard = new_setup.create_player_gameboard
    computer = Computer.new
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
    skip
    new_setup = GameSetupSequence.new("beginner")
    player_gameboard = new_setup.create_player_gameboard
    computer = Computer.new
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
    player_gameboard[3]["d4"].ship = true
    computer_guess = computer.select_random_available_square(player_gameboard)
    result = computer.calculate_result(computer_guess)
    assert_equal "hit", result

    player_gameboard[3]["d4"].ship = false
    computer_guess = computer.select_random_available_square(player_gameboard)
    result = computer.calculate_result(computer_guess)
    assert_equal "miss", result
  end

  def test_computer_takes_a_turn
    new_setup = GameSetupSequence.new("beginner")
    player_gameboard = new_setup.create_player_gameboard
    player_fleet = new_setup.player_fleet
    computer_display_board = DisplayBoard.new(player_gameboard)
    computer = Computer.new
    computer.computer_takes_a_turn(player_gameboard, computer_display_board, player_fleet)
    
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