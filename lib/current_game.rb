require_relative 'player'
require_relative 'display'

class CurrentGame
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @players_in_play = create_starting_players
  end 
  
  def display
    display = Display.new(@board)
    display.show
  end

  def create_starting_players
    white_player = Player.new('white', 'Bob')
    black_player = Player.new('black', 'Joe')
  end

  def play_turn
  end
end
