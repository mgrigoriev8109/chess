require_relative 'piece'
require 'movements'

class Bishop < Piece
  include Movements

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

  def all_possible_movements(board, rook_location)
    movements_array = Array.new
    movements_array.push(*movements_down_left(board, rook_location))
    movements_array.push(*movements_down_right(board, rook_location))
    movements_array.push(*movements_up_left(board, rook_location))
    movements_array.push(*movements_up_right(board, rook_location))
    movements_array.delete([])
    movements_array
  end

  def attacks_up_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new
    column_to_check = starting_row + starting_column

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if column_to_check == column_index && value.is_a?(Piece) && column_index > starting_column && value.color != @color
          possible_attack = Array.new
          possible_attack.push([row_index, column_index])
        elsif column_to_check == column_index&& value.is_a?(Piece) && column_index > starting_column && value.color == @color
          possible_attack = Array.new
        end
      end

      column_to_check -= 1
    end

    possible_attack
  end

  def attacks_down_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new
    column_to_check = starting_column + 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      if piece_in_the_way
        break
      end

      if row_index > starting_row
        board_row.each_with_index do |value, column_index| 
          if column_to_check == column_index && value.is_a?(Piece) && value.color != @color
            piece_in_the_way = true
            possible_attack.push([row_index, column_index])
          elsif column_to_check == column_index && value.is_a?(Piece) && value.color == @color
            piece_in_the_way = true
          end
        end
        column_to_check += 1
      end
    end
    possible_attack
  end

  def attacks_up_left(board, piece_location)
    ending_row = piece_location[0]
    ending_column = piece_location[1]
    possible_attack = Array.new
    dont_check_further = false
    column_to_check = ending_column - ending_row
    row_to_check = 0

    if ending_column < ending_row
      column_to_check = 0
      row_to_check = ending_row - ending_column
    end

    board.each_with_index do |board_row, row_index|
      if dont_check_further
        break
      end
      
      board_row.each_with_index do |value, column_index| 
        if column_to_check == ending_column && row_index >= row_to_check
          dont_check_further = true
        elsif column_to_check == column_index && row_index >= row_to_check && value.is_a?(Piece) && value.color != @color
          possible_attack = Array.new
          possible_attack.push([row_index, column_index])
          row_to_check += 1
          column_to_check += 1
        elsif column_to_check == column_index && row_index >= row_to_check && value.is_a?(Piece) && value.color == @color
          possible_attack = Array.new
          row_to_check += 1
          column_to_check += 1
        end
      end

    end
    possible_attack
  end
end