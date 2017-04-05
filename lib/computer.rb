class Computer
  attr_accessor :unsunk_ships
  
  def initialize(player_fleet)
    @unsunk_ships = player_fleet
  end

  def computer_takes_a_turn(player_gameboard, computer_display_board)
    system "clear"
    winner = false
    puts "\nNow it's the Computer's turn!"
    computer_guess = select_random_available_square(player_gameboard)
    result = calculate_result(computer_guess)
    computer_guess_name = computer_guess.name
    display_computer_result(result, computer_guess_name)
    if result == "hit"
      check_if_ship_is_sunk(unsunk_ships, player_gameboard)
      winner = check_if_fleet_is_sunk(unsunk_ships)
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
    if computer_guess.ship
      result = "hit"
    else
      result = "miss"
    end
    computer_guess.turn_result = result
  end

  def display_computer_result(result, computer_guess_name)
    puts "\nThe computer guessed #{computer_guess_name.upcase}. It was a #{result}!"
  end

  def cell(player_gameboard, cell_name)
    player_gameboard[(cell_name[0].upcase.ord - 65)][cell_name.downcase]
  end

  def create_cell_references_in_fleet(player_fleet, player_gameboard)
    player_fleet.map do |ship|
      ship.map do |cell_name|
        cell_name = cell(player_gameboard, cell_name)
      end
    end
  end

  def check_if_ship_is_sunk(unsunk_ships, player_gameboard)
    ship_length = 0
    smart_fleet = create_cell_references_in_fleet(unsunk_ships, player_gameboard)
    smart_fleet.each do |ship|
      ship_length = ship.length
      sunk = ship.all? do |cell|
        cell.turn_result == "hit"
      end
      if sunk
        puts "The computer sank the #{ship_length}-unit ship!"
        @unsunk_ships.delete_if do |ship|
          ship.length == ship_length
        end
      end
      return sunk
    end
  end

  def check_if_fleet_is_sunk(unsunk_ships)
    winner = false
    if unsunk_ships.empty?
      puts "The computer sank the entire fleet!"
      winner = true
    end
  end
end