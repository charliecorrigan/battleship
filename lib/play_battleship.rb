require './lib/game_setup_sequence'

class PlayBattleship

  def initialize
    run_game_sequences
  end

  def run_game_sequences
    start_time = get_time_stamp
    game_setup_sequence = GameSetupSequence.new
    computer_gameboard = game_setup_sequence.create_computer_gameboard
    player_gameboard = game_setup_sequence.create_player_gameboard
    # game_play_sequence = GamePlaySequence.new
    # end_time = get_time_stamp
    # game_end_sequence = GameEndSequence.new
  end

  def get_time_stamp
    time = Time.new
    time.strftime("%H:%M:%S")
  end
end