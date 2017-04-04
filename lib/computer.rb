class Computer

  def computer_takes_a_turn(player_gameboard, computer_display_board, player_fleet)
    winner = false
    puts "\n\n\n\n\n\n\nNow it's the Computer's turn!\n\n\n\n\n"
    computer_guess = select_random_available_square
    result = calculate_result(player_gameboard, computer_guess)
    display_computer_result(result, computer_guess)
  #   if result == "hit"
  #     winner = check_on_fleet(unsunk_ships, computer_gameboard)
  #   end
    computer_display_board.update(computer_guess, result)
    computer_display_board.display
    winner
  end

  def select_random_available_square(player_gameboard)
    size = player_gameboard.length
    valid = false
    until valid
      board_index = rand(size)
      key_index = rand(size)
      key = player_gameboard[board_index].keys[key_index]
      if player_gameboard[board_index][key].fired_on == false
        valid = true
      end
    end
    player_gameboard[board_index][key]
  end

  def calculate_result(computer_guess)
    is_hit = computer_guess.ship
    if is_hit
      computer_guess.turn_result = "hit"
      return "hit"
    else
      computer_guess.turn_result = "miss"
      return "miss"
    end
  end

  def display_computer_result(result, computer_guess)
    puts "\n\n\n\n\nThe computer guessed #{computer_guess.upcase}. It was a #{result}!"
  end
  # def is_guess_valid?(player_guess, computer_gameboard)
  #   if player_guess.length != 2
  #     puts "Error: That square name doesn't exist."
  #     valid_cell = false
  #     return valid_cell
  #   end
  #   possible_keys = list_possible_keys(computer_gameboard)
  #   split_user_input = player_guess.downcase.split
  #   valid_cell = split_user_input.all? do |input|
  #     possible_keys.include?(input)
  #   end
  #   if valid_cell != true
  #     puts "Error: That square name doesn't exist."
  #   elsif valid_cell && cell(computer_gameboard, player_guess).fired_on
  #     puts "Error: That square has already been fired upon."
  #     valid_cell = false
  #   end
  #   valid_cell
  # end
end