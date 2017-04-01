require 'pry'

class GenerateNewGameboard
  attr_reader :size
  def initialize(size)
    @size = size
  end

  # def generate_blank_gameboard(size)
  #   sequential_row_names = ("a".."z").to_a
  #   rows = sequential_row_names.slice(0..(size - 1))
  #   blank_gameboard = rows.map do |row|
  #     row = (1..size).map do |num|
  #       "#{row}#{num}"
  #     end
  #   end
  #   blank_gameboard
  # end

  def initialize_empty_gameboard_spaces(size)
    sequential_row_names = ("a".."z").to_a
    rows = sequential_row_names.slice(0..(size - 1))
    empty_gameboard_spaces = rows.map do |row|
      row = (1..size).map do |num|
        "#{row}#{num}"
      end
    end
    empty_gameboard_spaces
  end

end