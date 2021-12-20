require_relative 'player'
require_relative 'display'
require_relative 'rook'
require_relative 'king'
require_relative 'bishop'

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

  def create_starting_bishops
    board[0][2] = Bishop.new('white')
    board[0][5] = Bishop.new('black')
    board[7][2] = Bishop.new('white')
    board[7][5] = Bishop.new('black')
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

  def verify_check(attacking_player)
    is_defending_king_in_check = false
    all_of_players_attacks = Array.new
    king_location = []

    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.is_a?(King) && cell.color != attacking_player.color
          king_location = [row_index, column_index]
        elsif cell.is_a?(Piece) && cell.color == attacking_player.color
          cells_attacks = cell.all_possible_attacks(@board, [row_index, column_index])
          all_of_players_attacks.push(*cells_attacks)
        end
      end
    end

    if all_of_players_attacks.include?(king_location)
      is_defending_king_in_check = true
    end

    is_defending_king_in_check
  end
  
  #So, who would #verify_king_ending_location? 
  #it should happen inside of #play_turn, but after the until loop
  #it should happen as an if conditional - if the player's starting piece is a king

  #if the starting piece is a king
  #then we first run a method called #verify_check
  #this method will look at all of the other player's array_of_attacks, for ALL his pieces
  #this giant array will whittle down the king's array_of_movements to avoid ones that land
  #the king in Check

  #verify_check can also be used after a non-king piece moves to see if the move resulted
  #in a Check

  #the problem occurs when the king can attack something

  #the only way i can think of to check for that is to simulate one movement ahead
  #i'll have an instance variable called @simulation_board, that each turn gets updated
  #when it's time for the king to #verify_king_ending_location, we take the array of
  #the king's array_of_attacks, and we iterate through it using #simulate_king_attacks
  #this third method will perform king attack #move_gamepiece on the @simulation_board
  #then inside of #simulate_king_attacks we run #verify_check
  #if the king is now in check, then we remove this from the king's array_of_attacks

  #after check is running successfuly we can build checkmate
  #checkmate will occur when the king has nowhere to move. this doesn't mean the player
  #has to be moving the king. This could happen at any point, so it should be checked
  #immediately after #move_gamepiece, a #verify_checkmate method will run logic
  #very similar to #verify_king_ending_location, checking is there is anywhere for 
  #either of the player's kings to currently move or attack that would not land them
  #in a check position. If the array of moves/attacks is empty, that player is in checkmate
  #and it is a game over


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
