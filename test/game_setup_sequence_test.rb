require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_setup_sequence'
require 'pry'


class TestGameSetupSequence < Minitest::Test
  
  def test_it_exists
    new_setup = GameSetupSequence.new
    assert new_setup
  end

  def test_it_initializes_with_beginner_as_difficulty_by_default
    new_setup = GameSetupSequence.new
    assert_equal 4, new_setup.board_size
  end

  def test_board_size_is_effected_by_diffiulty
    new_setup = GameSetupSequence.new("beginner")
    assert_equal 4, new_setup.board_size
    new_setup = GameSetupSequence.new("intermediate")
    assert_equal 8, new_setup.board_size
    new_setup = GameSetupSequence.new("advanced")
    assert_equal 12, new_setup.board_size
  end

  def test_ship_quantity_is_effected_by_diffiulty
    new_setup = GameSetupSequence.new("beginner")
    assert_equal [2, 3], new_setup.ships_in_play
    new_setup = GameSetupSequence.new("intermediate")
    assert_equal [2, 3, 4], new_setup.ships_in_play
    new_setup = GameSetupSequence.new("advanced")
    assert_equal [2, 3, 4, 5], new_setup.ships_in_play
  end

  def test_create_computer_gameboard_return_values
    new_setup = GameSetupSequence.new("beginner")
    computer_gameboard = new_setup.create_computer_gameboard
    assert_equal Array, computer_gameboard.class
    assert_equal 4, computer_gameboard.length
    
    counter = 0
    computer_gameboard.each do |row|
      row.each do |cell|
        if cell[1].ship == true
          counter += 1
        end
      end
    end
    assert_equal 5, counter
  end

  def test_create_player_gameboard_return_values
    puts "**********TESTING NOTES*************************"
    puts "Currently testing #create_player_gameboard"
    puts "Enter ship coordinates to continue."
    puts "************************************************"
    new_setup = GameSetupSequence.new("beginner")
    player_gameboard = new_setup.create_player_gameboard
    assert_equal Array, player_gameboard.class
    assert_equal 4, player_gameboard.length
    counter = 0
    player_gameboard.each do |row|
      row.each do |cell|
        if cell[1].ship == true
          counter += 1
        end
      end
    end
    assert_equal 5, counter
  end
end