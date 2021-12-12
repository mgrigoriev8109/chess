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


  def row_movements(board, rook_location)
    rook_row = rook_location[0]
    rook_column = rook_location[1]
    row_array = Array.new 
    possible_rook_moves = Array.new
    
    board.each_with_index do |board_row, row_index|
      if rook_row == row_index
        row_array = board_row
      end
    end

    row_array.each_with_index do |value, current_column|
      if current_column > rook_column && value.is_a?(Rook)
        break
      elsif current_column > rook_column
        possible_rook_moves.push([rook_row, current_column])
      end
    end
    possible_rook_moves
  end
end
