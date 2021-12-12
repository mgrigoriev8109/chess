require_relative 'current_game'

class Rook

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♜"
    elsif @color == 'black'
      symbol = "♖"
    end
    symbol
  end


  def row_movements_right(board, rook_location)
    rook_row = rook_location[0]
    starting_location = rook_location[1]
    row_array = Array.new 
    possible_rook_moves = Array.new
    
    board.each_with_index do |board_row, row_index|
      if rook_row == row_index
        row_array = board_row
      end
    end

    row_array.each_with_index do |value, index|
      if index > starting_location && value.is_a?(Rook)
        break
      elsif index > starting_location
        possible_rook_moves.push([rook_row, index])
      end
    end

    possible_rook_moves
  end

  def row_movements_left(board, rook_location)
    rook_row = rook_location[0]
    reversed_starting_location = 7 - rook_location[1]
    row_array = Array.new 
    possible_rook_moves = Array.new
    
    board.each_with_index do |board_row, row_index|
      if rook_row == row_index
        row_array = board_row.reverse
      end
    end

    row_array.each_with_index do |value, index|
      if index > reversed_starting_location && value.is_a?(Rook)
        break
      elsif index > reversed_starting_location
        reversed_column = 7 - index
        possible_rook_moves.push([rook_row, reversed_column])
      end
    end

    possible_rook_moves
  end
end
