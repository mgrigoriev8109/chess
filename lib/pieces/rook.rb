# frozen_string_literal: true

require_relative 'piece'
require_relative 'bishop_rook_movements'
require_relative 'bishop_rook_attacks'

class Rook < Piece
  include BishopRookMovements
  include BishopRookAttacks

  attr_reader :color
  attr_accessor :has_moved

  def initialize(color)
    @color = color
    @has_moved = false
  end

  def symbol
    case @color
    when 'white'
      symbol = '♜'
    when 'black'
      symbol = '♖'
    end
    symbol
  end

  def all_possible_attacks(board, rook_location)
    attacks_array = []
    attacks_array.push(*attacks_right(board, rook_location))
    attacks_array.push(*attacks_left(board, rook_location))
    attacks_array.push(*attacks_up(board, rook_location))
    attacks_array.push(*attacks_down(board, rook_location))
    attacks_array.delete([])
    attacks_array
  end

  def all_possible_movements(board, rook_location)
    movements_array = []
    movements_array.push(*movements_right(board, rook_location))
    movements_array.push(*movements_left(board, rook_location))
    movements_array.push(*movements_up(board, rook_location))
    movements_array.push(*movements_down(board, rook_location))
    movements_array.delete([])
    movements_array
  end
end
