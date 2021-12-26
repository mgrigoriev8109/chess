require_relative 'piece'

class WhitePawn < Piece
  attr_reader :color

  def initialize(color)
    @color = 'white'
  end

  def symbol
    symbol = "♟︎"
    symbol
  end

  def movement
  
  end
end
