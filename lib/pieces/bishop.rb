require_relative 'piece'
require_relative 'bishop_rook_movements'
require_relative 'bishop_rook_attacks'

class Bishop < Piece
  include BishopRookMovements
  include BishopRookAttacks

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = '♝'
    elsif @color == 'black'
      symbol = '♗'
    end
    symbol
  end

  def all_possible_movements(board, piece_location)
    movements_array = []
    movements_array.push(*movements_down_left(board, piece_location))
    movements_array.push(*movements_down_right(board, piece_location))
    movements_array.push(*movements_up_left(board, piece_location))
    movements_array.push(*movements_up_right(board, piece_location))
    movements_array.delete([])
    movements_array
  end

  def all_possible_attacks(board, piece_location)
    attacks_array = []
    attacks_array.push(*attacks_down_left(board, piece_location))
    attacks_array.push(*attacks_down_right(board, piece_location))
    attacks_array.push(*attacks_up_left(board, piece_location))
    attacks_array.push(*attacks_up_right(board, piece_location))
    attacks_array.delete([])
    attacks_array
  end
end
