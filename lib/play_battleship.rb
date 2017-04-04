require './lib/game_setup_sequence'
require './lib/game_play_sequence'
require './lib/game_end_sequence'

class PlayBattleship

  def initialize
    run_game_sequences
  end

  def run_game_sequences
    start_time = get_time_stamp
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    computer_fleet = game_setup_sequence.computer_fleet
    player_gameboard = game_setup_sequence.create_player_gameboard
    player_fleet = game_setup_sequence.player_fleet
    game_play_sequence = GamePlaySequence.new(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    end_time = get_time_stamp
    winner = game_play_sequence.won
    computer_turns = game_play_sequence.computer_turns
    player_turns = game_play_sequence.player_turns
    game_end_sequence = GameEndSequence.new(winner, start_time, end_time, computer_turns, player_turns)
  end

  def get_time_stamp
    time = Time.new
    time.strftime("%H:%M:%S")
  end
end