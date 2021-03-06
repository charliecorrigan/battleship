require './lib/cell'
require 'pry'

class GenerateNewGameboard
  attr_reader :size
  def initialize(size)
    @size = size
  end

  def generate_blank_gameboard
    gameboard_spaces = initialize_empty_gameboard_spaces
    blank_gameboard = gameboard_spaces.map do |letter_array|
      row = {} 
      letter_array.each do |cell_name|
        row[cell_name] = Cell.new(cell_name)
      end
      row
    end
    blank_gameboard
    end
      
  def initialize_empty_gameboard_spaces
    sequential_row_names = ("a".."z").to_a
    rows = sequential_row_names.slice(0..(size - 1))
    empty_gameboard_spaces = rows.map do |row|
      row = (1..size).map do |num|
        "#{row}#{num}"
      end
    end
    empty_gameboard_spaces
  end

  def link_gameboard_cells(unlinked_gameboard)
    sequential_row_names = ("a".."z").to_a
    row_letters = sequential_row_names.slice(0..(size - 1))
    assign_all_up_attributes(unlinked_gameboard, row_letters)
    assign_all_down_attributes(unlinked_gameboard, row_letters)
    assign_all_right_attributes(unlinked_gameboard)
    assign_all_left_attributes(unlinked_gameboard)
  end

    def assign_all_up_attributes(gameboard, row_letters)
      gameboard.each_with_index do |row, index|
        if index > 0
          row.keys.each do |key|
            first_letter = key.split("").first
            new_index = (row_letters.index(first_letter)) - 1
            pointer_letter = row_letters[new_index]
            pointer = key.sub(first_letter, pointer_letter)
            gameboard[index][key].up = gameboard[index - 1][pointer]
          end
        end
      end
    end

  def assign_all_down_attributes(gameboard, row_letters)
    gameboard.each_with_index do |row, index|
      if index < (size - 1)
        row.keys.each do |key|
          first_letter = key.split("").first
          new_index = (row_letters.index(first_letter)) + 1
          pointer_letter = row_letters[new_index]
          pointer = key.sub(first_letter, pointer_letter)
          gameboard[index][key].down = gameboard[index + 1][pointer]
        end
      end
    end
  end

  def assign_all_right_attributes(gameboard)
    gameboard.each_with_index do |row, index|
      row.keys.each do |key|
        number = key.split("").last
        if number.to_i < row.length
          pointer_number = (number.to_i + 1).to_s
          pointer = key.sub(number, pointer_number)
          gameboard[index][key].right = gameboard[index][pointer]
        end
      end
    end
  end

  def assign_all_left_attributes(gameboard)
    gameboard.each_with_index do |row, index|
      row.keys.each do |key|
        number = key.split("").last
        if number.to_i > 1
          pointer_number = (number.to_i - 1).to_s
          pointer = key.sub(number, pointer_number)
          gameboard[index][key].left = gameboard[index][pointer]
        end
      end
    end
  end
end