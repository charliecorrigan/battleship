require 'pry'
class PlayerOne
  attr_accessor :unsunk_ships

def initialize(computer_fleet)
  @unsunk_ships = computer_fleet
end
  
  def player_takes_a_turn(computer_gameboard, player_one_display_board)
    winner = false
    puts "\n\n\n\Your turn, Player One!\n"
    player_one_display_board.display
    player_guess = get_valid_player_input(computer_gameboard)
    result = calculate_result(player_guess)
    player_guess_name = player_guess.name
    display_result(result)
    if result == "hit"
      sunk = check_if_ship_is_sunk(unsunk_ships, computer_gameboard)
        if sunk
          winner = check_if_fleet_is_sunk(unsunk_ships)
        end
    end
    player_one_display_board.update(player_guess_name, result)
    player_one_display_board.display
    winner
  end

  def get_valid_player_input(computer_gameboard)
    valid = false
    until valid
      player_guess = solicit_player_guess
      valid = is_guess_valid?(player_guess, computer_gameboard)
      valid
    end
    cell(computer_gameboard, player_guess).fired_on = true
    player_guess = cell(computer_gameboard, player_guess)
  end

  def solicit_player_guess
    puts "Enter the coordinate you wish to fire upon."
    player_guess = gets.chomp
  end

  def calculate_result(player_guess)
    if player_guess.ship
      result = "hit"
    else
      result = "miss"
    end
    player_guess.turn_result = result
  end

  def is_guess_valid?(player_guess, computer_gameboard)
    if player_guess.length != 2
      puts "Error: That square name doesn't exist."
      valid_cell = false
      return valid_cell
    end
    possible_keys = list_possible_keys(computer_gameboard)
    split_user_input = player_guess.downcase.split
    valid_cell = split_user_input.all? do |input|
      possible_keys.include?(input)
    end
    if valid_cell != true
      puts "Error: That square name doesn't exist."
    elsif valid_cell && cell(computer_gameboard, player_guess).fired_on
      puts "Error: That square has already been fired upon."
      valid_cell = false
    end
    valid_cell
  end

  def cell(computer_gameboard, cell_name)
    computer_gameboard[(cell_name[0].upcase.ord - 65)][cell_name.downcase]
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

  def display_result(result)
    puts "\nIt was a #{result}!"
  end

  def create_cell_references_in_fleet(computer_fleet, computer_gameboard)
    computer_fleet.map do |ship|
      ship.map do |cell_name|
        cell_name = cell(computer_gameboard, cell_name)
      end
    end
  end

  def check_if_ship_is_sunk(unsunk_ships, computer_gameboard)
    ship_length = 0
    sunk = false
    smart_fleet = create_cell_references_in_fleet(unsunk_ships, computer_gameboard)
    smart_fleet.each do |ship|
      ship_length = ship.length
      sunk = ship.all? do |cell|
        cell.turn_result == "hit"
      end
      if sunk
        puts "You sank the #{ship_length}-unit ship!"
        @unsunk_ships.delete_if do |ship|
          ship.length == ship_length
        end
      end
      return sunk
    end
    #return sunk
  end

  def check_if_fleet_is_sunk(unsunk_ships)
    winner = false
    if unsunk_ships.empty?
      puts "You sank the entire fleet!"
      winner = true
    end
    winner
  end  
end