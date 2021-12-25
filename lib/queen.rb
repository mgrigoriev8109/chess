require_relative 'piece'
require 'movements'

class Queen < Piece
  include Movements

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♛"
    elsif @color == 'black'
      symbol = "♕"
    end
    symbol
  end
end