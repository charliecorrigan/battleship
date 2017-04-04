
class PlayerOne

  def player_takes_a_turn(computer_gameboard, player_one_display_board) #ships_and_locations
    winner = false
    player_one_display_board.display
    # player_guess = get_valid_player_input(computer_gameboard)
    # result = calculate_result(player_guess)
    # display_result(result)
    # if result = "hit"
    # if result = "hit"
    #   sunk = check_is_ship_is_sunk?
    #     if sunk
    #       check_if_all_ships_sunk?
    #     end
    # end   
    # player_one_display_board.update
    # player_one_display_board.display
    # winner
  end

  def get_valid_player_input(computer_gameboard)
    valid = false
    until valid
      player_guess = solicit_player_guess
      valid = is_guess_valid?(player_guess, computer_gameboard)
      valid
    end
    player_guess
  end

  def solicit_player_guess
    puts "Enter the coordinate you wish to fire upon."
    player_guess = gets.chomp
    player_guess
  end

  def is_guess_valid?(player_guess, computer_gameboard)
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

  def cell(computer_gameboard, player_guess)
    computer_gameboard[(player_guess[0].upcase.ord - 65)][player_guess.downcase]
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

  def calculate_result(player_guess)
    #<----is cell.ship? change cell status to return "hit"
  end
end