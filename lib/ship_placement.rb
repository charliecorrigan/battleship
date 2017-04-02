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

  def find_next_cell(current_cell, direction)
    if direction == "up"
      if current_cell.up == nil
        next_cell = nil
      else
        next_cell = current_cell.up
      end
    elsif direction == "down"
      if current_cell.down == nil
        next_cell = nil
      else
        next_cell = current_cell.down
      end
    elsif direction == "right"
      if current_cell.right == nil
        next_cell = nil
      else
        next_cell = current_cell.right
      end
    else
      if current_cell.left == nil
        next_cell = nil
      else
        next_cell = current_cell.left
      end
    end
    next_cell
  end

  def find_valid_random_direction(first_coordinate, ship_size)
    valid = false
    until valid
      ship_coordinates = [first_coordinate]
      current_cell = first_coordinate
      direction = select_random_direction
      next_cell = find_next_cell(current_cell, direction)
      (ship_size - 1).times do
        if next_cell.nil?
          valid = false
          break
        else
          valid = true
          current_cell = next_cell
          ship_coordinates << current_cell
        end
      end
    end
    ship_coordinates
  end

  def computer_selects_ship_placement(gameboard, size, ship_size)
    first_coordinate = select_random_coordinate(gameboard, size)
    ship_coordinates = find_valid_random_direction(first_coordinate, ship_size)
    ship_coordinates
  end
end