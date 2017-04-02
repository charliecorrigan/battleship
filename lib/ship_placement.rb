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
      puts "entering the until loop"
      ship_coordinates = [first_coordinate]
      puts "first_coordinate is #{first_coordinate.name}"
      current_cell = first_coordinate
      direction = select_random_direction
      puts "direction is #{direction}"
      next_cell = find_next_cell(current_cell, direction)
      if next_cell.nil?
        puts "next cell is nil"
      else
        puts "next_cell is #{next_cell.name}"
      end
      puts "ship size minus 1 is #{(ship_size - 1)}"
      counter = 0
      (ship_size - 1).times do
        counter += 1
        puts "do times counter is #{counter}"
        if next_cell.nil?
          puts "next_cell cell was nil. About to escape. We should reenter the loop"
          valid = false
          break
        else
          puts "next_cell wasn't nil'"
          valid = true
          current_cell = next_cell
          ship_coordinates << current_cell
          puts "first ship_coordinates are currently #{ship_coordinates[0].name}"
          puts "last ship_coordinates are currently #{ship_coordinates[-1].name}"
        end
      end
    end
    #binding.pry
    message = ""
    ship_coordinates.each do |cell|
      message << cell.name
    end
    puts "Ship coordinates at end of method are #{message}"
    ship_coordinates
  end

  # def computer_selects_ship_placement(gameboard, size, ship_size)
  #   first_coordinate = select_random_coordinate(gameboard, size)
  #   ship_coordinates = find_valid_random_direction(first_coordinate)
  #   
  # end
end