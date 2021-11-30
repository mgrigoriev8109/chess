require_relative 'player'
require_relative 'display'

class CurrentGame
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
  end 
  
  def display
    display = Display.new(@board)
    display.show
  end

  def create_game_players
    white_player = Player.new('white', 'Bob')
    black_player = Player.new('black', 'Joe')
  end

  def create_game_pieces
    white_player.create_player_pieces
    black_player.create_player_pieces
  end
end
