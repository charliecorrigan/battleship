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
        row[cell_name] = Cell.new
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

end