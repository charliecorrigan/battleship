require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_end_sequence'

class TestGameEndSequence < Minitest::Test

  def test_it_exists
    winner = "player"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    end_game = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
    assert end_game
  end

  def test_game_end_message_output
    winner = "player"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    end_game = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
    assert_equal "CONGRATULATIONS! You have won the game!", end_game.message(winner)

    winner = "computer"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    end_game = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
    assert_equal "I AM SO SORRY. You have lost the game!\nYou must be really embarrassed. I hope you feel better soon.", end_game.message(winner)
  end

  def test_length_of_game_returns_accurate_length
    winner = "player"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    end_game = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
    assert_equal "Game duration: 00:10:38", end_game.length_of_game(start_time, end_time)
  end

  def test_number_of_turns_returns_correct_number
    winner = "player"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    end_game = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
    assert_equal "You won in 7 moves.", end_game.number_of_turns(winner, computer_turns, player_turns)
    winner = "computer"
    start_time = "05:25:02"
    end_time = "05:35:40"
    computer_turns = 6
    player_turns = 7
    assert_equal "The computer won in 6 moves.", end_game.number_of_turns(winner, computer_turns, player_turns)
  end

end