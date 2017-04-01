require './lib/generate_new_gameboard'

class GameSetupSequence
  attr_reader :board_size
  def initialize(difficulty = "beginner")
    @board_size = select_board_size(difficulty)
  end

  def select_board_size(difficulty)
    size = 4 if difficulty == "beginner"
    size = 8 if difficulty == "intermediate"
    size = 12 if difficulty == "advanced"
    size
  end

  def create_computer_gameboard
    new_computer_gameboard = GenerateNewGameboard.new(board_size)
    computer_gameboard = new_computer_gameboard.generate_blank_gameboard
    new_computer_gameboard.link_gameboard_cells(computer_gameboard)
    # computer_ship_placement = ShipPlacement.new
    # computer_ship_placement.assign_ship_coordinates("computer")
    # computer_gameboard = new_computer_gameboard.populate_gameboard_with_ships(new_game_board, ships)
    # computer_gameboard
  end

  # create_player_gameboard
  #   generate_new_gameboard
  #   place_ships(player)
  #   update_gameboard
end