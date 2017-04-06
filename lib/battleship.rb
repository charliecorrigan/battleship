require './lib/play_battleship'

class Battleship
  attr_reader :header, :welcome_message, :title_screen_options, :instructions

  def initialize
    @header =                " __     _  _____ ______ __   ____  __   __   __  _______  ____\n|   \\  / \\ L   _|L   _| | |  | _| /  _\\ | |  | | |_   _| |    \\\n| L\\| / _ \\ | |   | |   | |  | |  | |   | |  | |   | |   | L\\  |\n|  _/|  _  || |   | |   | |  | |_  \\ \\  | L__| |   | |   |  __/\n|   \\| | | || |   | |   | |  |  _|  | | |  ___ |   | |   | |\n| L\\|| | | || |   | |   | l_ | |_  _/ / | |  | |  _| |__ | |\n|___||_| |_||_|   |_|   |___||___||__/  |_|  |_| |______||_|"
    @welcome_message =       "\nWelcome to BATTLESHIP\n\n"  
    @title_screen_options =  "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n\n>"
    @instructions =          "Type your commands followed by the 'enter' key."
    display_title_screen
    process_title_screen_options
  end

  def display_title_screen
    system "clear"
    puts header
    puts welcome_message
    puts title_screen_options
  end

  def process_title_screen_options
    quit_option =           "q"
    instructions_option =   "i"
    play_option =           "p"
    user_choice =           ""
    until user_choice.downcase == play_option || user_choice.downcase == quit_option
    user_choice = gets.chomp
      if user_choice.downcase == play_option
        new_game = PlayBattleship.new
      elsif user_choice.downcase == instructions_option
        puts instructions
        puts title_screen_options
      elsif user_choice.downcase == quit_option
        break
      else
        puts title_screen_options
      end
    end
  end
end

b = Battleship.new



   