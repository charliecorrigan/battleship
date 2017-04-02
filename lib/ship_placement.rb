class ShipPlacement
  attr_reader :ships

  def initialize(ships)
    @ships = ships
  end

  def select_random_coordinate(gameboard, size)
    board_index = rand(3)
    key_index = rand(3)
    gameboard[board_index].keys[2]
  end

  

end