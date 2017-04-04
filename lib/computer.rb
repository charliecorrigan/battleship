class Computer

  def computer_takes_a_turn(player_gameboard, computer_display_board, player_fleet)
    winner = false
    puts "\n\n\nNow it's the Computer's turn!"
    computer_guess = select_random_available_square(player_gameboard)
    result = calculate_result(computer_guess)
    computer_guess_name = computer_guess.name
    display_computer_result(result, computer_guess_name)
    if result == "hit"
      winner = check_on_fleet(player_fleet, player_gameboard)
    end
    computer_display_board.update(computer_guess_name, result)
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
    player_gameboard[board_index][key].fired_on = true
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

  def display_computer_result(result, computer_guess_name)
    puts "\nThe computer guessed #{computer_guess_name.upcase}. It was a #{result}!"
  end

  def cell(player_gameboard, cell_name)
    player_gameboard[(cell_name[0].upcase.ord - 65)][cell_name.downcase]
  end

  def check_on_fleet(player_fleet, player_gameboard)
    ship_length = 0
    smart_fleet = player_fleet.map do |ship|
      ship.map do |cell_name|
        cell_name = cell(player_gameboard, cell_name)
      end
    end
    smart_fleet.each do |ship|
      ship_length = ship.length
      sunk = ship.all? do |cell|
        cell.turn_result == "hit"
      end
      if sunk
        puts "The computer sank the #{ship_length}-unit ship!"
      end
      sunk
    end
    if smart_fleet.empty?
      puts "You sank the entire fleet!"
      winner = true
    end
    winner
  end

end