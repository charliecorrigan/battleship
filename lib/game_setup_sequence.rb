require './lib/generate_new_gameboard'
require './lib/ship_placement'
require 'pry'

class GameSetupSequence
  attr_reader :difficulty, :board_size, :ships_in_play, :player_fleet, :computer_fleet
  def initialize(difficulty = "beginner")
    @difficulty = difficulty
    @board_size = select_board_size(difficulty)
    @ships_in_play = select_ships_in_play(difficulty)
    @ship_quantity = ships_in_play.length
    @player_fleet = []
    @computer_fleet = []
  end

  def select_board_size(difficulty)
    size = 4 if difficulty == "beginner"
    size = 8 if difficulty == "intermediate"
    size = 12 if difficulty == "advanced"
    size
  end

  def select_ships_in_play(difficulty)
    ships = [2, 3] if difficulty == "beginner"
    ships = [2, 3, 4] if difficulty == "intermediate"
    ships = [2, 3, 4, 5] if difficulty == "advanced"
    ships
  end

  def create_computer_gameboard
    new_computer_gameboard = GenerateNewGameboard.new(board_size)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    computer_ship_placement = ShipPlacement.new(ships_in_play)
    ships_in_play.each do |this_ship|
      ship_coordinates = computer_ship_placement.computer_selects_ship_placement(computer_gameboard, board_size, this_ship)
      save_computer_ship_coordinates(ship_coordinates)
      computer_ship_placement.place_ship_on_board(ship_coordinates)
    end
    computer_gameboard
  end

  def save_computer_ship_coordinates(ship_coordinates)
    ship_coordinate_names = []
    ship_coordinates.each do |cell|
      ship_coordinate_names << cell.name
    end
    @computer_fleet << ship_coordinate_names
  end

  def create_player_gameboard
    new_player_gameboard = GenerateNewGameboard.new(board_size)
    player_gameboard = new_player_gameboard.generate_blank_gameboard
    new_player_gameboard.link_gameboard_cells(player_gameboard)
    player_ship_placement = ShipPlacement.new(ships_in_play)
    player_ship_placement.show_ship_placement_instructions(difficulty)
    ships_in_play.each do |this_ship|
      ship_coordinates = player_ship_placement.player_selects_ship_placement(player_gameboard, this_ship)
      @player_fleet << ship_coordinates
      player_ship_placement.place_ship_on_board(ship_coordinates)
    end
    player_gameboard
  end
end