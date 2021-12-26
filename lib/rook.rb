require_relative 'piece'
require 'bishop_rook_movements'
require 'bishop_rook_attacks'

class Rook < Piece
  include BishopRookMovements
  include BishopRookAttacks

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

  def all_possible_attacks(board, rook_location)
    attacks_array = Array.new
    attacks_array.push(*attacks_right(board, rook_location))
    attacks_array.push(*attacks_left(board, rook_location))
    attacks_array.push(*attacks_up(board, rook_location))
    attacks_array.push(*attacks_down(board, rook_location))
    attacks_array.delete([])
    attacks_array
  end

  def all_possible_movements(board, rook_location)
    movements_array = Array.new
    movements_array.push(*movements_right(board, rook_location))
    movements_array.push(*movements_left(board, rook_location))
    movements_array.push(*movements_up(board, rook_location))
    movements_array.push(*movements_down(board, rook_location))
    movements_array.delete([])
    movements_array
  end

end
