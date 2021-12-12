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


  def movements_right(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    moves_to_look_through = Array.new 
    possible_moves = Array.new
    
    board.each_with_index do |board_row, row_index|
      if starting_row == row_index
        moves_to_look_through = board_row
      end
    end

    moves_to_look_through.each_with_index do |value, index|
      if index > starting_column && value.is_a?(Rook)
        break
      elsif index > starting_column
        possible_moves.push([starting_row, index])
      end
    end

    possible_moves
  end

  def movements_left(board, rook_location)
    starting_row = rook_location[0]
    reversed_starting_location = 7 - rook_location[1]
    moves_to_look_through = Array.new 
    possible_moves = Array.new
    
    board.each_with_index do |board_row, row_index|
      if starting_row == row_index
        moves_to_look_through = board_row.reverse
      end
    end

    moves_to_look_through.each_with_index do |value, index|
      if index > reversed_starting_location && value.is_a?(Rook)
        break
      elsif index > reversed_starting_location
        reversed_column = 7 - index
        possible_moves.push([starting_row, reversed_column])
      end
    end

    possible_moves
  end

  def movements_down(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    moves_to_look_through = Array.new 
    possible_moves = Array.new



    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if starting_column == column_index
          moves_to_look_through.push(value)
        end
      end
    end

    moves_to_look_through.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Rook)
        break
      elsif index > starting_row
        possible_moves.push([index, starting_column])
      end
    end

    possible_moves
  end
end
