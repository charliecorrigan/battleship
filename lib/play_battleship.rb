class PlayBattleship

  def initialize
    run_game_sequences
  end

  def run_game_sequences
    start_time = get_time_stamp
    game_setup_sequence = GameSetupSequence.new
    game_play_sequence = GamePlaySequence.new
    end_time = get_time_stamp
    game_end_sequence = GameEndSequence.new
  end

  def get_time_stamp
    time = Time.new
    time.strftime("%H:%M:%S")
  end
end