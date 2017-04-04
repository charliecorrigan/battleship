class GamePlaySequence

  def initialize(player_gameboard, computer_gameboard, computer_fleet)
    run_game_play_sequence(player_gameboard, computer_gameboard)
  end

  def run_game_play_sequence
    take_turns_playing(player_gameboard, computer_gameboard)
  end

  def take_turns_playing
    player_one = PlayerOne.new
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    computer = Computer.new
    computer_display_board = DisplayBoard.new(player_gameboard)
    winner = 0
    until winner > 0
      win = player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, computer_fleet)
        if win
          winner += 1
        end
      win = computer.computer_takes_a_turn(player_gameboard, computer_display_board, player_fleet)
        if win
          winner += 1
        end
    end
  end
end