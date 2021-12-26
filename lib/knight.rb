require_relative 'piece'

class Knight < Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♞"
    elsif @color == 'black'
      symbol = "♘"
    end
    symbol
  end 

  def find_possible_movement(board, possible_row, possible_column)
    possible_move = Array.new
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if row_index == possible_row && column_index == possible_column && value == ' '
          possible_move.push([row_index, column_index])
        end
      end
    end
    possible_move
  end

  def movements_up_right(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column + 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_up_left(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column - 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_right_up(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 1
    possible_column = knight_column + 2
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

end