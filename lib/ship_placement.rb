require 'pry'

class ShipPlacement
  attr_reader :ships

  def initialize(ships)
    @ships = ships
  end

  def select_random_coordinate(gameboard, size)
    valid = false
    until valid
      board_index = rand(size)
      key_index = rand(size)
      key = gameboard[board_index].keys[key_index]
      if gameboard[board_index][key].ship == false
        valid = true
      end
    end
    gameboard[board_index][key]
  end

  def select_random_direction
    value = rand(3)
    if value == 0
      direction = "up"
    elsif value == 1
      direction = "down"
    elsif value == 2
      direction = "right"
    else
      direction = "left"
    end
    direction
  end

  def next_cell(current_cell, direction)
    if direction == "up"
      current_cell.up
    elsif direction == "down"
      current_cell.down
    elsif direction == "right"
      current_cell.right
    else
      current_cell.left
    end
  end
  # def computer_selects_ship_placement(gameboard, size, ship_size)
  #   first_coordinate = select_random_coordinate(gameboard, size)
  #   remaining_coordinates = find_valid_random_direction
  #   ship_coordinates = [first_coordinate].merge(remaining_coordinates)
  # end
end