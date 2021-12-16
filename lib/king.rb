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

  def all_possible_movements(board, king_location)
    movements_array = Array.new
    movements_array.push(movements_right(board, king_location)[0])
    movements_array.push(movements_left(board, king_location)[0])
    movements_array.push(movements_up(board, king_location)[0])
    movements_array.push(movements_down(board, king_location)[0])
    movements_array.delete(nil)
    movements_array
  end

end