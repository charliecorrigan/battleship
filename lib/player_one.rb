require 'pry'
class PlayerOne

  def player_takes_a_turn(computer_gameboard, player_one_display_board, unsunk_ships)
    winner = false
    puts "\n\n\n\n\n\n\nYour turn, Player One!\n"
    player_one_display_board.display
    player_guess = get_valid_player_input(computer_gameboard)
    result = calculate_result(computer_gameboard, player_guess)
    display_result(result)
    if result == "hit"
      winner = check_on_fleet(unsunk_ships, computer_gameboard)
    end
    player_one_display_board.update(player_guess, result)
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
    player_guess
  end

  def solicit_player_guess
    puts "Enter the coordinate you wish to fire upon."
    player_guess = gets.chomp
    player_guess
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

  def calculate_result(computer_gameboard, player_guess)
    is_hit = cell(computer_gameboard, player_guess).ship
    if is_hit
      cell(computer_gameboard, player_guess).turn_result = "hit"
      return "hit"
    else
      cell(computer_gameboard, player_guess).turn_result = "miss"
      return "miss"
    end
  end

  def display_result(result)
    puts "\nIt was a #{result}!"
  end

  def check_on_fleet(unsunk_ships, computer_gameboard)
    ship_length = 0
    smart_fleet = unsunk_ships.map do |ship|
      ship.map do |cell_name|
        cell_name = cell(computer_gameboard, cell_name)
      end
    end
    smart_fleet.delete_if do |ship|
      ship_length = ship.length
      sunk = ship.all? do |cell|
        cell.turn_result == "hit"
      end
      if sunk
        # unless unsunk_ships == nil
        #   @unsunk_ships.delete_if do |ship|
        #     ship.length == ship_length
        #   end
        # end
        puts "You sank the #{ship_length}-unit ship!"
        
      end
      sunk
    end
    # if !smart_fleet.empty?
    #   smart_fleet.each do |ship|
    #   unsunk_ship = []
    #   # ship.each do |cell|
    #   #   unsunk_ship << cell.name
    #   # end
    #   end
    # end 
    if smart_fleet.empty?
      @unsunk_ships = []
      puts "You sank the entire fleet!"
      winner = true
    end
    winner
  end
end