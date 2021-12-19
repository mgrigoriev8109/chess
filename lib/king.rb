require_relative 'piece'
require 'movements'

class King < Piece
  include Movements

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♚"
    elsif @color == 'black'
      symbol = "♔"
    end
    symbol
  end

  def all_possible_movements(board, piece_location)
    movements_array = Array.new
    movements_array.push(movements_right(board, piece_location)[0])
    movements_array.push(movements_left(board, piece_location)[0])
    movements_array.push(movements_up(board, piece_location)[0])
    movements_array.push(movements_down(board, piece_location)[0])
    movements_array.push(movements_down_left(board, piece_location)[0])
    movements_array.push(movements_down_right(board, piece_location)[0])
    movements_array.push(movements_up_left(board, piece_location)[0])
    movements_array.push(movements_up_right(board, piece_location)[0])
    movements_array.delete(nil)
    movements_array
  end

  def all_possible_attacks(board, piece_location)
    attacks_array = Array.new
    attacks_array.push(*attacks_right(board, piece_location))
    attacks_array.push(*attacks_left(board, piece_location))
    attacks_array.push(*attacks_up(board, piece_location))
    attacks_array.push(*attacks_down(board, piece_location))
    attacks_array.push(*attacks_down_left(board, piece_location))
    attacks_array.push(*attacks_down_right(board, piece_location))
    attacks_array.push(*attacks_up_left(board, piece_location))
    attacks_array.push(*attacks_up_right(board, piece_location))
    attacks_array.delete([])
    attacks_array
  end

  def attacks_right(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = row_to_look_through(board, starting_row)
    possible_attack = Array.new
  
    attacks_to_look_through.each_with_index do |value, index|
      if (index == starting_column + 1) && value.is_a?(Piece) && value.color != @color
        possible_attack.push([starting_row, index])
      end
    end
    
    possible_attack
  end

  def attacks_left(board, rook_location)
    starting_row = rook_location[0]
    starting_column = 7 - rook_location[1]
    attacks_to_look_through = row_to_look_through(board, starting_row)
    possible_attacks = Array.new
    attacks_to_look_through.reverse.each_with_index do |value, index|
      if (index == starting_column + 1) && value.is_a?(Piece) && value.color != @color
        index = 7 - index
        possible_attacks.push([starting_row, index])
      end
    end
    possible_attacks
  end

  def attacks_down(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = column_to_look_through(board, starting_column)
    possible_attack = Array.new
  
    attacks_to_look_through.each_with_index do |value, index|
      if (index == starting_row + 1) && value.is_a?(Piece) && value.color != @color
        possible_attack.push([index, starting_column])
      end
    end
    
    possible_attack
  end

  def attacks_up(board, rook_location)
    starting_row = 7 - rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = column_to_look_through(board, starting_column)
    possible_attack = Array.new
  
    attacks_to_look_through.reverse.each_with_index do |value, index|
      if (index == starting_row + 1) && value.is_a?(Piece) && value.color != @color
        index = 7 - index
        possible_attack.push([index, starting_column])
      end
    end
    
    possible_attack
  end

  def attacks_up_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if (row_index == starting_row - 1) && (column_index == starting_column + 1) && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end

    possible_attack
  end

  def attacks_down_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if (row_index == starting_row + 1) && (column_index == starting_column + 1) && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end

    possible_attack
  end  
  
  def attacks_up_left(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if (row_index == starting_row - 1) && (column_index == starting_column - 1) && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end

    possible_attack
  end

  def attacks_down_left(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if (row_index == starting_row + 1) && (column_index == starting_column - 1) && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end

    possible_attack
  end
end