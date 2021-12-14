require_relative 'player'
require_relative 'display'
require_relative 'rook'

class CurrentGame
  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
  end 

  def show_display
    display = Display.new
    display.transform_to_symbol(@board)
    display.show
  end 

  def create_starting_rooks
    @board[0][0] = Rook.new('black')
    @board[0][7] = Rook.new('black')
    @board[7][0] = Rook.new('white')
    @board[7][7] = Rook.new('white')
  end
  
  def create_players
    player_black = Player.new('black', 'player_black')
    player_white = Player.new('white', 'player_white')
  end

  def populate_gameboard
    create_starting_rooks
  end

  def play_turn
    create_players
    populate_gameboard
    puts "#{player_white.name} it is now your turn."
    player_white.get_input_array
    verify_starting_location(player_white)
  end

  def move_gamepiece(player)
    row = player.starting_location[0]
    column = player.starting_location[1]
    @board[row][column].all_possible_movements
  end

  def verify_starting_location(player)
    is_location_verified = false
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if player.starting_location == [row_index, column_index] && cell == ' '
          is_location_verified = false
        elsif player.starting_location == [row_index, column_index] && cell.color == player.color
          is_location_verified = true
        end
      end
    end
    is_location_verified
  end
  
end
