class GamePlaySequence

  def initialize(player_gameboard, computer_gameboard)
    run_game_play_sequence(player_gameboard, computer_gameboard)
  end

  def run_game_play_sequence
    take_turns_playing(player_gameboard, computer_gameboard)
  end

  def take_turns_playing
    player_one = PlayerOne.new
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    computer = Computer.new
    winner = nil
    until winner
      winner = player_one.player_takes_a_turn(computer_gameboard, player_one_display_board)
      winner = computer.computer_takes_a_turn(player_gameboard)
    end
  end
end