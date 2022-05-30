require_relative 'piece'
require_relative 'knight_movements'
require_relative 'knight_attacks'

class Knight < Piece
  include KnightMovements
  include KnightAttacks

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = '♞'
    elsif @color == 'black'
      symbol = '♘'
    end
    symbol
  end

  def find_possible_movement(board, possible_row, possible_column)
    possible_move = []
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index|
        if row_index == possible_row && column_index == possible_column && value == ' '
          possible_move.push([row_index, column_index])
        end
      end
    end
    possible_move
  end

  def find_possible_attack(board, possible_row, possible_column)
    possible_attack = []
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index|
        if row_index == possible_row && column_index == possible_column && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end
    possible_attack
  end

  def all_possible_movements(board, rook_location)
    movements_array = []
    movements_array.push(*movements_up_right(board, rook_location))
    movements_array.push(*movements_up_left(board, rook_location))
    movements_array.push(*movements_right_up(board, rook_location))
    movements_array.push(*movements_right_down(board, rook_location))
    movements_array.push(*movements_down_right(board, rook_location))
    movements_array.push(*movements_down_left(board, rook_location))
    movements_array.push(*movements_left_up(board, rook_location))
    movements_array.push(*movements_left_down(board, rook_location))
    movements_array.delete([])
    movements_array
  end

  def all_possible_attacks(board, rook_location)
    attacks_array = []
    attacks_array.push(*attacks_up_right(board, rook_location))
    attacks_array.push(*attacks_up_left(board, rook_location))
    attacks_array.push(*attacks_right_up(board, rook_location))
    attacks_array.push(*attacks_right_down(board, rook_location))
    attacks_array.push(*attacks_down_right(board, rook_location))
    attacks_array.push(*attacks_down_left(board, rook_location))
    attacks_array.push(*attacks_left_up(board, rook_location))
    attacks_array.push(*attacks_left_down(board, rook_location))
    attacks_array.delete([])
    attacks_array
  end
end
