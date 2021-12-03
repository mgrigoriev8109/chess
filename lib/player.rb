require_relative 'rook'

class Player

  attr_reader :rooks_in_play

  def initialize(color, name)
    @color = color
    @name = name
    create_starting_rooks(color)
  end

  def create_starting_rooks(color)
    @rooks_in_play = Array.new
    if color == 'white'
      @rooks_in_play.push(Rook.new(color, '[0][7]'))
      #@rooks_in_play.push(Rook.new(color, '[7][7]'))
    elsif color == 'black'
      @rooks_in_play.push(Rook.new(color, '[0][0]'))
      @rooks_in_play.push(Rook.new(color, '[7][0]'))
    end
  end
end

player = Player.new('white', 'bob')
p player.rooks_in_play