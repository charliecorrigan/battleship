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
      coordinate = gameboard[board_index][key]
      if coordinate.ship == false
        valid = true
      end
    end
    coordinate
  end

  def select_random_direction
    value = rand(4)
    direction = "up" if value == 0
    direction = "down" if value == 1
    direction = "right" if value == 2
    direction = "left" if value == 3
    direction
  end

  def find_next_cell(current_cell, direction)
    next_cell = current_cell.up if direction == "up"
    next_cell = current_cell.down if direction == "down"
    next_cell = current_cell.right if direction == "right"
    next_cell = current_cell.left if direction == "left"
    next_cell
  end

  def find_valid_random_direction(first_coordinate, ship_size)
    valid = false
    until valid
      ship_coordinates = [first_coordinate]
      current_cell = first_coordinate
      direction = select_random_direction
      (ship_size - 1).times do
        next_cell = find_next_cell(current_cell, direction)
        if next_cell.nil? || next_cell.ship
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

  def player_selects_ship_placement(gameboard, ship_size)
      possible_keys = list_possible_keys(gameboard)
      ship_coordinates = nil
      while ship_coordinates.nil?
        player_input = solicit_user_input(ship_size)
          if user_input_contains_cell_names(player_input, possible_keys)
            ship_coordinates = validate_player_coordinates(gameboard, player_input, ship_size)
          end
      end
      ship_coordinates
  end

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

  def user_input_contains_cell_names(user_input, possible_keys)
    split_user_input = user_input.downcase.split
    contain_cell_names = split_user_input.all? do |input|
      possible_keys.include?(input)
    end
    if contain_cell_names != true
      puts "Error: That square name doesn't exist."
    end
    contain_cell_names
  end


  def player_input_rows(coordinates)
    coordinate_rows = coordinates.map do |coordinate|
        coordinate[0]
      end
    coordinate_rows  
  end

  def player_input_columns(coordinates)
    coordinate_columns = coordinates.map do |coordinate|
        coordinate[1]
      end
    coordinate_columns
  end

  def player_input_rows_as_numbers(coordinates)
    coordinate_rows_as_numbers = coordinates.map do |row|
        row = 1 if row == "a"
        row = 2 if row == "b"
        row = 3 if row == "c"
        row = 4 if row == "d"
        row
      end
    coordinate_rows_as_numbers
  end

  # def validate_player_coordinates(gameboard, player_input, ship_size)
  #     individual_coordinates = player_input.downcase.split
  #     coordinate_rows = player_input_rows(individual_coordinates)
  #     coordinate_columns = player_input_columns(individual_coordinates)
  #     coordinate_rows_as_numbers = player_input_rows_as_numbers(coordinate_rows)
      
  #     if coordinate_rows.uniq.length > 1 && coordinate_columns.uniq.length > 1
  #       puts "Ships cannot be placed diagonally."
  #       return
  #     end
  #     if coordinate_rows.uniq.length == 1
  #       spread = coordinate_columns[0].to_i - coordinate_columns[-1].to_i
  #       if (spread.abs + 1) != ship_size
  #         puts "Ship doesn't fit in squares provided."
  #         return
  #       else
  #         if spread < 0
  #           direction = "right"
  #         else
  #           direction = "left"
  #         end
  #       end
  #     end
  #     if coordinate_columns.uniq.length == 1
  #       spread = coordinate_rows_as_numbers[0] - coordinate_rows_as_numbers[-1]
  #       if (spread.abs + 1) != ship_size
  #         puts "Ship doesn't fit in squares provided."
  #         return
  #       else
  #         if spread < 0
  #           direction = "down"
  #         else
  #           direction = "up"
  #         end
  #       end
  #     end
      
  #       current_cell = gameboard[(coordinate_rows_as_numbers[0] - 1)][(individual_coordinates[0])]
  #       if current_cell.ship
  #         puts "Error: Ships cannot overlap."
  #         return
  #       end
  #       ship_coordinates = [current_cell]
        
  #       (ship_size - 1).times do
  #         next_cell = find_next_cell(current_cell, direction)
          
  #         if next_cell.ship 
  #           puts "Error: Ships cannot overlap."
  #           ship_coordinates = nil
  #           return
  #         else
  #           ship_coordinates << next_cell
  #           current_cell = next_cell
  #         end
  #       end
  #       ship_coordinates
  # end

  def validate_player_coordinates(gameboard, player_input, ship_size)
      individual_coordinates = player_input.downcase.split
      coordinate_rows = player_input_rows(individual_coordinates)
      coordinate_columns = player_input_columns(individual_coordinates)
      coordinate_rows_as_numbers = player_input_rows_as_numbers(coordinate_rows)
      return if ships_are_diagonal(coordinate_rows, coordinate_columns)
      if coordinates_are_all_in_same_row(coordinate_rows)
        spread = distance_between_coordinates(coordinate_columns)
        return if ship_doesnt_fit(spread, ship_size)
        direction = "right" if spread < 0
        direction = "left" if spread > -1
        end
      end
      if coordinates_are_all_in_same_column(coordinate_columns)
        spread = distance_between_coordinates(coordinate_rows_as_numbers)
        return if ship_doesnt_fit(spread, ship_size)
        direction = "down" if spread < 0
        direction = "up" if spread > -1
      end
  end    
  
  def ships_are_diagonal(coordinate_rows, coordinate_columns)
    if coordinate_rows.uniq.length > 1 && coordinate_columns.uniq.length > 1
      puts "Ships cannot be placed diagonally."
      return true
    end
  end

  def coordinates_are_all_in_same_row(coordinate_rows)
    coordinate_rows.uniq.length == 1
  end

  def distance_between_coordinates(columns_or_rows)
    columns_or_rows[0].to_i - columns_or_rows[-1].to_i
  end
  
  def ship_doesnt_fit(spread, ship_size)
    if (spread.abs + 1) != ship_size
      puts "Ship doesn't fit in squares provided."
      return true
    end
  end

  def coordinates_are_all_in_same_column(coordinate_columns)
    coordinate_columns.uniq.length == 1
  end
      
  def declare_current_cell(gameboard, coordinate_rows_as_numbers, individual_coordinates)
    gameboard[(coordinate_rows_as_numbers[0] - 1)][(individual_coordinates[0])]
  end

  def ships_overlap(current_cell)
    if current_cell.ship
      puts "Error: Ships cannot overlap."
      return true
    end
  end  
        current_cell = declare_current_cell(gameboard, coordinate_rows_as_numbers, individual_coordinates)
        return if ships_overlap(current_cell)
        ship_coordinates = [current_cell]
        
        (ship_size - 1).times do
          next_cell = find_next_cell(current_cell, direction)
          
          if next_cell.ship 
            puts "Error: Ships cannot overlap."
            ship_coordinates = nil
            return
          else
            ship_coordinates << next_cell
            current_cell = next_cell
          end
        end
        ship_coordinates
  end
end