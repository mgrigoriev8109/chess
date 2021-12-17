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

end