require_relative 'current_game'

class Rook

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

  def possible_movements(rook_location)
    possible_rook_moves = Array.new

    #look at the rooks entire row 
    #  use a (for loop?) loop to iterate through the row until we hit something other than " "
    #    add each set of coordinates to our possible_moves array
    #look at the rooks entire column
    #  use a loop to iterate through the row until we hit something other than " "
    #    add each set of coordinates to our possible_moves array

    possible_rook_moves
  end
end
