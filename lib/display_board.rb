require 'pry'

class DisplayBoard
  
  attr_accessor :current_board

  def initialize(working_gameboard)
    working_gameboard_size = working_gameboard.length
    @current_board = []
    generate_blank_display_board(working_gameboard_size)
  end

  def generate_blank_display_board(working_gameboard_size)
    generate_border(working_gameboard_size)
    generate_column_headers(working_gameboard_size)
    generate_table_body(working_gameboard_size)
    generate_border(working_gameboard_size)
  end

  def generate_border(working_gameboard_size)
    @current_board << ("=" * (working_gameboard_size * 2 + 1))
  end

  def generate_column_headers(working_gameboard_size)
    column_headers = "."
    (1..working_gameboard_size).each do |num|
      column_headers += " #{num.to_s}"
    end
    @current_board << column_headers
  end

  def generate_table_body(working_gameboard_size)
    table_body = []
    counter = working_gameboard_size
    row_name = "A"
    until counter < 1
      table_body << "#{row_name}".ljust(working_gameboard_size * 2)
      row_name = row_name.next
      counter -= 1
    end
    table_body.each do |row|
      @current_board << row
    end
  end
  # def add_row(working_gameboard_size, row_name = "A", table_body = [], counter)
  #   if counter == 0
  #     return table_body
  #   else
  #     table_body << "#{row_name}".ljust(working_gameboard_size * 2)
  #     add_row(working_gameboard_size, row_name.next, table_body, (counter - 1))
  #   end
  # end

end