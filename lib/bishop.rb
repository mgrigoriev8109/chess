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

end