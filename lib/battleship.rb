require './lib/play_battleship'

welcome_message =       "\nWelcome to BATTLESHIP\n\n"
title_screen_options =  "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n\n>"
quit_option =           "q"
instructions_option =   "i"
play_option =           "p"
instructions =          "Type your commands followed by the 'enter' key."
user_choice =           ""
header = " __     _  _____ ______ __   ____  __   __   __  _______  ____\n|   \\  / \\ L   _|L   _| | |  | _| /  _\\ | |  | | |_   _| |    \\\n| L\\| / _ \\ | |   | |   | |  | |  | |   | |  | |   | |   | L\\  |\n|  _/|  _  || |   | |   | |  | |_  \\ \\  | L__| |   | |   |  __/\n|   \\| | | || |   | |   | |  |  _|  | | |  ___ |   | |   | |\n| L\\|| | | || |   | |   | l_ | |_  _/ / | |  | |  _| |__ | |\n|___||_| |_||_|   |_|   |___||___||__/  |_|  |_| |______||_|"


puts header

puts welcome_message

puts title_screen_options
until user_choice.downcase == play_option || user_choice.downcase == quit_option
  user_choice = gets.chomp
  if user_choice.downcase == play_option then new_game = PlayBattleship.new
  elsif user_choice.downcase == instructions_option
    puts instructions
    puts title_screen_options
  elsif user_choice.downcase == quit_option
    break
  else
    puts title_screen_options
  end
end


   