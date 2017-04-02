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
    value = rand(4)
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
      current_cell.up
    elsif direction == "down"
      current_cell.down
    elsif direction == "right"
      current_cell.right
    else
      current_cell.left
    end
  end

  def find_valid_random_direction(first_coordinate, ship_size)
    valid = false
    until valid
      ship_coordinates = [first_coordinate]
      current_cell = first_coordinate
      direction = select_random_direction
      (ship_size - 1).times do
        next_cell = find_next_cell(current_cell, direction)
        if next_cell.nil? || next_cell.ship == true
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

  def place_ship_on_board(ship_coordinates)
    ship_coordinates.each do |cell|
      cell.ship = true
    end
  end

  def show_ship_placement_instructions(difficulty)
    number_of_ships = ""
    message = "I have laid out my ships on the grid.\nYou now need to layout your #{number_of_ships} ships.\n"
    if difficulty == "beginner"
      number_of_ships = "two"
      message += "The first is two units long and the\nsecond is three units long.\n"
    elsif difficulty == "intermediate"
      number_of_ships = "three"
      message += "The first is two units long, the\nsecond is three units long, and the\nthird is four units long.\n"
    else
      number_of_ships = "four"
      message += "The first is two units long, the\nsecond is three units long, the\nthird is four units long, and\nthe fouth is five units long.\n"
    end
    message +="The grid has A1 at the top left and D4 at the bottom right."
    puts message
    message
  end

  # def player_selects_ship_placement(gameboard, ship_size)
  #     ship_coordinates = []
  #     while ship_coordinates.empty?
  #       player_input = solicit_user_input(ship_size)
  #       ship_coordinates = validate_player_coordinates(gameboard, player_input)
  #     end
  #     ship_coordinates
  # end

  def solicit_user_input(ship_size)
    units = "two" if ship_size == 2
    units = "three" if ship_size == 3
    units = "four" if ship_size == 4
    units = "five" if ship_size == 5
    message = "Enter the squares for the #{units}-unit ship."
    puts message
    user_input = gets.chomp
    user_input
  end

  def list_possible_keys(gameboard)
    possible_keys = []
    gameboard.each do |row|
      row.each do |cell|
        possible_keys << cell[1].name
      end
    end
    possible_keys
  end

  def user_input_contains_cell_names(user_input, possible_keys, ship_size)
    split_user_input = user_input.downcase.split
    contain_cell_names = split_user_input.all? do |input|
      possible_keys.include?(input)
    end
    if contain_cell_names != true
      puts "Error: That square name doesn't exist."
    end
    contain_cell_names
  end
end