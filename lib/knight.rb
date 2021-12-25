require_relative 'piece'

class Knight < Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♞"
    elsif @color == 'black'
      symbol = "♘"
    end
    symbol
  end 
end