require_relative 'player'
require_relative 'display'
require_relative 'rook'

class CurrentGame
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @display = Display.new(@board)
  end 

  def create_starting_rooks
    @board[0][7] = Rook.new('white')
    @board[7][7] = Rook.new('white')
    @board[0][0] = Rook.new('black')
    @board[7][0] = Rook.new('black')
  end
  
end