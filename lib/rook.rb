require_relative 'piece'

class Rook
  def initialize(color, rooks_in_play)
    @color = color
    @rooks_in_play = Array.new
  end

  def create_starting_rooks(color, location)
    @rooks_in_play.push(Piece.new(color, location))
  end
end