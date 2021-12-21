require_relative 'player'
require_relative 'display'
require_relative 'rook'
require_relative 'king'
require_relative 'bishop'

class CurrentGame
  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @simulation_board = Array.new
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
    move_gamepiece(player, @board)
  end

  def get_starting_piece(player)
    row = player.starting_location[0]
    column = player.starting_location[1]
    starting_piece = @board[row][column]
    starting_piece
  end

  def verify_ending_location(player)
    starting_piece = get_starting_piece(player)

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

  def get_player_possible_attacks(attacking_player, board)
    all_of_players_attacks = Array.new

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.is_a?(Piece) && cell.color == attacking_player.color
          cells_attacks = cell.all_possible_attacks(@board, [row_index, column_index])
          all_of_players_attacks.push(*cells_attacks)
        end
      end
    end
    p all_of_players_attacks
    all_of_players_attacks
  end

  def get_king_location(attacking_player)
    king_location = []

    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.is_a?(King) && cell.color != attacking_player.color
          king_location = [row_index, column_index]
        end
      end
    end
    king_location
  end

  def verify_check(attacking_player, board)
    is_defending_king_in_check = false
    all_of_players_attacks = get_player_possible_attacks(attacking_player, board)
    defending_king_location = get_king_location(attacking_player)

    if all_of_players_attacks.include?(defending_king_location)
      is_defending_king_in_check = true
    end

    is_defending_king_in_check
  end
  
  def verify_king_ending_location(king_player, other_player)
    simulated_board = @board
    king_movements = Array.new
    impossible_movements = Array.new
    can_piece_move_or_attack = false

    king_movements.push(*starting_piece.all_possible_movements(@board, king_player.starting_location))
    king_movements.push(*starting_piece.all_possible_attacks(@board, king_player.starting_location))
    
    king_movements.each do |movement|
      king_player.ending_location = movement
      move_gamepiece(king_player, simulated_board)
      if verify_check(other_player, simulated_board)
        impossible_movements.push(movement)
      end
    end
    king_movements = king_movements - impossible_movements

    if king_movements.include?(king_player.ending_location)
      can_piece_move_or_attack = true
    end 

    can_piece_move_or_attack
  end



  #verify_check will be its own method used to verify if a defending king is in check
  #after a moving player makes a movement or an attack
  # by looking through all the possible attacks of an attacking player
  #this will be used to tell the USERS that there is a check occuring

  #verify_king_ending_location will be inside of play_turn after t
  #the until loop, it will be a conditional which will verify
  #if the player moving a king can actually place it on the desired landing location

  #verify_king_ending_location will need to check if the king is landing on a spot 
  #the opponents pieces can attack. I might as well keep this simple. 
  #I'll simulate one movement ahead using @simulation_board, that each turn gets updated
  #with the present state of the board

  #inside of #verify_king_ending_location, we take the array of
  #the king's possible movements and attacks, and we iterate through it using #simulate_king_movements
  
  #simulate_king_movements will #move_gamepiece and then run #verify_check on the @simulated_board
  #if the king is now in check, then we add that movement to an array impossible_moves

  #after we iterate through every possible king move and attack, we take the ones left over, 
  #and use if to check if the desired movement is included in them

  #after check is running successfuly we can build checkmate
  #checkmate will occur when the king has nowhere to move. this doesn't mean the player
  #has to be moving the king. This could happen at any point, so it should be checked
  #immediately after #move_gamepiece, a #verify_checkmate method will run logic
  #very similar to #verify_king_ending_location, checking is there is anywhere for 
  #either of the player's kings to currently move or attack that would not land them
  #in a check position. If the array of moves/attacks is empty, that player is in checkmate
  #and it is a game over


  def move_gamepiece(player, board)
    starting_row = player.starting_location[0]
    starting_column = player.starting_location[1]

    ending_row = player.ending_location[0]
    ending_column = player.ending_location[1]

    board[ending_row][ending_column] = @board[starting_row][starting_column]

    board[starting_row][starting_column] = ' '
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
