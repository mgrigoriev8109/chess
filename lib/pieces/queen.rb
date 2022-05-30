# frozen_string_literal: true

require_relative 'piece'
require_relative 'bishop_rook_movements'
require_relative 'bishop_rook_attacks'

class Queen < Piece
  include BishopRookMovements
  include BishopRookAttacks

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    case @color
    when 'white'
      symbol = '♛'
    when 'black'
      symbol = '♕'
    end
    symbol
  end

  def all_possible_movements(board, piece_location)
    movements_array = []
    movements_array.push(*movements_down_left(board, piece_location))
    movements_array.push(*movements_down_right(board, piece_location))
    movements_array.push(*movements_up_left(board, piece_location))
    movements_array.push(*movements_up_right(board, piece_location))
    movements_array.push(*movements_right(board, piece_location))
    movements_array.push(*movements_left(board, piece_location))
    movements_array.push(*movements_up(board, piece_location))
    movements_array.push(*movements_down(board, piece_location))
    movements_array.delete([])
    movements_array
  end

  def all_possible_attacks(board, piece_location)
    attacks_array = []
    attacks_array.push(*attacks_down_left(board, piece_location))
    attacks_array.push(*attacks_down_right(board, piece_location))
    attacks_array.push(*attacks_up_left(board, piece_location))
    attacks_array.push(*attacks_up_right(board, piece_location))
    attacks_array.push(*attacks_right(board, piece_location))
    attacks_array.push(*attacks_left(board, piece_location))
    attacks_array.push(*attacks_up(board, piece_location))
    attacks_array.push(*attacks_down(board, piece_location))
    attacks_array.delete([])
    attacks_array = attacks_array.uniq
  end
end
