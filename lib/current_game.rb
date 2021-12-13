require_relative 'player'
require_relative 'display'
require_relative 'rook'

class CurrentGame
  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @display
  end 

  def create_display
    @display = Display.new(@board)
  end 

  def show_display
    @display.show
  end

  def update_display
    @display.gameboard = @board
  end

  def create_starting_rooks
    @board[0][7] = Rook.new('white')
    @board[7][7] = Rook.new('white')
    @board[0][0] = Rook.new('black')
    @board[7][0] = Rook.new('black')
  end
  
  def play_turn
    player_white = Player.new('white', 'player1')
    puts "#{player_white.name} it is now your turn."
    create_starting_rooks
    player_white.get_input_array
    verify_starting_location(player_white)
  end

  def verify_starting_location(player)
    is_location_verified = false
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if player.starting_location == [row_index, column_index] && cell != " "
          is_location_verified = true
        end
      end
    end
    is_location_verified
  end

end