class GameEndSequence

  def initialize(winner, start_time, end_time, computer_turns, player_turns)
    system "clear"
    display_game_end_messages(winner, start_time, end_time, computer_turns, player_turns)
  end

  def message(winner)
    if winner == "computer"
      `say "I AM SO SORRY...You have lost the game!...You must be really embarrassed...I hope you feel better soon."`
      return "\nI AM SO SORRY. You have lost the game!\nYou must be really embarrassed. I hope you feel better soon."
    else
      `say "You sank all enemy ships...You win!"`
      return "\nCONGRATULATIONS! You have won the game!"
    end
  end

  def length_of_game(start_time, end_time)
    start_time = start_time.split(":")
    end_time = end_time.split(":")
    hours = end_time[0].to_i - start_time[0].to_i
    minutes = end_time[1].to_i - start_time[1].to_i
    seconds = end_time[2].to_i - start_time[2].to_i
    while seconds < 0
      seconds = 60 - seconds
      minutes -=1
    end
    while seconds > 60
      seconds -= 60
      minutes += 1
    end
    "Game duration: #{"%02d" % hours}:#{"%02d" % minutes}:#{"%02d" % seconds}"
  end

  def number_of_turns(winner, computer_turns, player_turns)
    if winner == "computer"
      "The computer won in #{computer_turns} moves."
    else
      "You won in #{player_turns} moves."
    end
  end

  def display_game_end_messages(winner, start_time, end_time, computer_turns, player_turns)
    puts message(winner)
    puts number_of_turns(winner, computer_turns, player_turns)
    puts length_of_game(start_time, end_time)
  end
end