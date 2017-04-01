class GameSetupSequence
  attr_reader :difficulty

  def initialize(difficulty = "beginner")
    @difficulty = difficulty
  end

  # create_computer_gameboard
  #   generate_new_gameboard
  #   place_ships(computer)
  #   update_gameboard

  # create_player_gameboard
  #   generate_new_gameboard
  #   place_ships(player)
  #   update_gameboard
end