require './lib/generate_new_gameboard'
require './lib/ship_placement'

class GameSetupSequence
  attr_reader :board_size, :ships_in_play
  def initialize(difficulty = "beginner")
    @board_size = select_board_size(difficulty)
    @ships_in_play = select_ships_in_play(difficulty)
    @ship_quantity = ships_in_play.length
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
      computer_ship_placement.place_ship_on_board(ship_coordinates)
    end
    computer_gameboard
  end

  # create_player_gameboard
  #   generate_new_gameboard
  #   place_ships(player)
  #   update_gameboard
end