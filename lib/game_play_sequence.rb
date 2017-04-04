require './lib/player_one'
require './lib/computer'
require './lib/display_board'

class GamePlaySequence
  attr_reader :won, :computer_turns, :player_turns
  
  def initialize(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    run_game_play_sequence(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
  end

  def run_game_play_sequence(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    take_turns_playing(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
  end

  def take_turns_playing(player_gameboard, computer_gameboard, player_fleet, computer_fleet)
    player_one = PlayerOne.new(computer_fleet)
    player_one_display_board = DisplayBoard.new(computer_gameboard)
    computer = Computer.new(player_fleet)
    computer_display_board = DisplayBoard.new(player_gameboard)
    @won = ""
    winner = 0
    @computer_turns = 0
    @player_turns = 0
    until winner > 0
      player_wins = player_one.player_takes_a_turn(computer_gameboard, player_one_display_board, computer_fleet)
      @player_turns += 1
        if player_wins
          @won = "player"
          winner += 1
          return
        end
      puts "Hit 'ENTER' to continue..."
      continue = gets
      computer_wins = computer.computer_takes_a_turn(player_gameboard, computer_display_board)
      @computer_turns += 1
        if computer_wins
          @won = "computer"
          winner += 1
          return
        end
      puts "Hit 'ENTER' to continue..."
      continue = gets
    end
    won
  end
end