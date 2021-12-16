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
    create_players
    create_starting_rooks
  end

  def play_turn(player)
    puts "#{player.name} it is now your turn."
    until verify_starting_location(player) &&  verify_ending_location(player)
      player.get_input_array
    end
    move_gamepiece(player)
  end

  def verify_ending_location(player)
    row = player.starting_location[0]
    column = player.starting_location[1]
    starting_piece = @board[row][column]

    array_of_movements = starting_piece.all_possible_movements(@board, player.starting_location)
    array_of_attacks = starting_piece.all_possible_attacks(@board, player.starting_location)
    can_piece_move_or_attack = false

    if array_of_movements.include?(player.ending_location)
      can_piece_move_or_attack = true
    elsif array_of_attacks.include?(player.ending_location)
      can_piece_move_or_attack = true
    end 

    can_piece_move_or_attack
  end

  def move_gamepiece(player)
    starting_row = player.starting_location[0]
    starting_column = player.starting_location[1]

    ending_row = player.ending_location[0]
    ending_column = player.ending_location[1]

    @board[ending_row][ending_column] = @board[starting_row][starting_column]

    @board[starting_row][starting_column] = ' '
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
