require_relative 'player'
require_relative 'display'
require_relative 'rook'
require_relative 'king'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'white_pawn'
require_relative 'black_pawn'
require_relative 'create_pieces'

class CurrentGame
  include CreatePieces
  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @simulation_board = Array.new
  end 

  def introduction
    puts "Welcome to a CLI game of Chess!"
    puts "Two players will take turns playing against each other until one player achieves Checkmate"
    puts "The white player will be taking the first turn."
  end

  def populate_gameboard
    create_starting_rooks
    create_starting_bishops
    create_starting_kings
    create_starting_queens
    create_starting_knights
    create_starting_pawns
  end

  def create_player(color)
    player_name = gets.chomp
    player = Player.new(color, player_name)
    player
  end

  def show_display
    display = Display.new
    display.transform_to_symbol(@board)
    display.show
  end 

  def play_turn(player)
    show_display
    puts "#{player.name} it is now your turn."
    while player.get_input_array
      if verify_movement(player.movement, player.color)
        puts "This movement is valid."
        break
      else
        puts "This movement is not valid, please try again."
      end
    end
    
    move_gamepiece(player.starting_location, player.ending_location, @board)

    assess_check_checkmate(player.color, @board)
    assess_endofround_enpassant(player.starting_location, player.ending_location, @board)
    assess_pawn_promotion(@board)
    assess_castling_execution(player.color, @board)
    assess_castling_possibility(player.color, @board)
    assess_has_king_moved(player.starting_location, @board)
  end

  def assess_pawn_promotion(board)
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if row_index == 0 && cell.is_a?(WhitePawn)
          board[column_index][row_index] = Queen.new('white')
          puts 'A White Pawn has been promoted to a White Queen'
        elsif row_index == 7 && cell.is_a?(BlackPawn)
          board[column_index][row_index] = Queen.new('black')
          puts 'A Black Pawn has been promoted to a Black Queen'
        end
      end
    end
  end

  def assess_check_checkmate(color, board)
    if assess_endofround_checkmate(player.color, @board)
      puts "Looks like #{player.name} has won and put the opposing player into Checkmate!"
    elsif assess_endofround_check(player.color, @board)
      puts "Looks like #{player.name} has put the opposing player into Check!"
    end

  end
  
  def assess_endofround_enpassant(starting_coordinates, ending_coordinates, board)
    starting_piece = get_piece(starting_coordinates)
    starting_row = starting_coordinates[0]
    ending_row = ending_coordinates[0]

    if starting_piece.is_a?(WhitePawn) && starting_row == 6 && ending_row == 4 
      verify_enpassant_by_black_pawn(ending_coordinates, board)
    elsif starting_piece.is_a?(BlackPawn) && starting_row == 1 && ending_row == 3
      verify_enpassant_by_white_pawn(ending_coordinates, board)
    end

  end

  def assess_has_king_moved(starting_location, board)
    piece_being_moved = get_piece(starting_location)
    if piece_being_moved.is_a?(King)
      piece_being_moved.has_moved = true
    end
  end

  def assess_castling_possibility(color, board)
    other_player_color = opposite_player_color(color)
    king_start = get_king_location(other_player_color, board)
    castling_row = king_start[0]
    if verify_castling_left(other_player_color, board)
      king_end = [castling_row, 2]
      castling_king = get_piece(king_start)
      castling_king.can_castling_coordinates = king_end
    elsif verify_castling_right(other_player_color, board)
      king_end = [castling_row, 6]
      castling_king = get_piece(king_start)
      castling_king.can_castling_coordinates = king_end
    end
  end

  def verify_castling_left(color, board)
    #if king has not moved during game, rook has not moved during game
    #if there are no pieces between king and rook
    #if king is not in check
    #if king will not be in check on any of the other two squares
  end

  def verify_castling_right(color, board)
    #if king has not moved during game, rook has not moved during game
    #if there are no pieces between king and rook
    #if king is not in check
    #if king will not be in check on any of the other two squares
  end

  def assess_castling_execution(color, starting_location, ending_location, board)
    if get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 2
      move_castling_rook_left(color, board)
    elsif get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 6
      move_castling_rook_right(color, board)
    end
  end

  def move_castling_rook_left(color, board)
    king_start = get_king_location(color, board)
    castling_row = king_start[0]
    rook_start = [castling_row, 0]
    rook_end = [castling_row, 3]
    move_gamepiece(rook_start, rook_end, board)
  end

  def move_castling_rook_right(color, board)
    king_start = get_king_location(color, board)
    castling_row = king_start[0]
    rook_start = [castling_row, 7]
    rook_end = [castling_row, 5]
    move_gamepiece(rook_start, rook_end, board)
  end
  
  def verify_enpassant_by_white_pawn(ending_location, board)
    black_pawn_column = ending_location[1]
    white_pawn_row = ending_location[0]
    white_pawn_columns = [(black_pawn_column - 1), (black_pawn_column + 1)]

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if white_pawn_row == 3 && white_pawn_columns.include?(column_index) && cell.is_a?(WhitePawn)
          cell.can_en_passant_column = black_pawn_column
        end
      end
    end
  end

  def verify_enpassant_by_black_pawn(ending_location, board)
    white_pawn_column = ending_location[1]
    black_pawn_row = ending_location[0]
    black_pawn_columns = [(white_pawn_column - 1), (white_pawn_column + 1)]

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if black_pawn_row == 4 && black_pawn_columns.include?(column_index) && cell.is_a?(BlackPawn)
          cell.can_en_passant_column = white_pawn_column
        end
      end
    end
  end

  def verify_movement(movement, color)
    is_movement_verified = false
    starting_coordinates = [movement[0], movement[1]]
    ending_coordinates = [movement[2], movement[3]]
    is_movement_verified = verify_start(starting_coordinates, color)
    is_movement_verified = verify_end(starting_coordinates, ending_coordinates, color)
    is_movement_verified
  end

  def verify_start(starting_coordinates, color)
    is_location_verified = false
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if starting_coordinates == [row_index, column_index] && cell == ' '
          is_location_verified = false
        elsif starting_coordinates == [row_index, column_index] && cell.color == color
          is_location_verified = true
        end
      end
    end

    is_location_verified
  end

  def verify_end(starting_coordinates, ending_coordinates, color)
    starting_piece = get_piece(starting_coordinates)
    all_movements = Array.new
    impossible_movements = Array.new
    can_piece_move_or_attack = false

    all_movements.push(*starting_piece.all_possible_movements(@board, starting_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(@board, starting_coordinates))

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(starting_coordinates, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        impossible_movements.push(possible_end)
      end
    end
    all_movements = all_movements - impossible_movements

    if all_movements.include?(ending_coordinates)
      can_piece_move_or_attack = true
    end 
    can_piece_move_or_attack
  end

  def get_piece(coordinates)
    row = coordinates[0]
    column = coordinates[1]
    starting_piece = @board[row][column]
    starting_piece
  end

  def move_gamepiece(starting_location, ending_location, board)
    starting_row = starting_location[0]
    starting_column = starting_location[1]

    ending_row = ending_location[0]
    ending_column = ending_location[1]

    board[ending_row][ending_column] = @board[starting_row][starting_column]

    board[starting_row][starting_column] = ' '
  end

  def verify_check(color, board)
    is_defending_king_in_check = false
    all_possible_attacks = get_all_attacks_against(color, board)
    defending_king_location = get_king_location(color, board)

    if all_possible_attacks.include?(defending_king_location)
      is_defending_king_in_check = true
    end

    is_defending_king_in_check
  end

  def get_all_attacks_against(color, board)
    all_attacks = Array.new

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.is_a?(Piece) && cell.color != color
          cells_attacks = cell.all_possible_attacks(board, [row_index, column_index])
          all_attacks.push(*cells_attacks)
        end
      end
    end
    all_attacks
  end

  def get_king_location(color, board)
    king_location = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell.is_a?(King) && cell.color == color
          king_location = [row_index, column_index]
        end
      end
    end
    king_location
  end

  def assess_endofround_check(current_player_color, board)
    is_other_player_in_check = false
    current_player_color

    if current_player_color == 'white'
      other_player_color = 'black'
      is_other_player_in_check = verify_check(other_player_color, board)
    elsif current_player_color =='black'
      other_player_color = 'white'
      is_other_player_in_check = verify_check(other_player_color, board)
    end
    
    is_other_player_in_check
  end

  def assess_endofround_checkmate(current_player_color, board)
    is_other_player_in_check = false
    other_player_color = opposite_player_color(current_player_color)
    is_other_player_in_check = verify_checkmate(other_player_color, board)
    is_other_player_in_check
  end

  def opposite_player_color(current_player_color)
    opposite_color = ''
    if current_player_color == 'white'
      opposite_color = 'black'
    elsif current_player_color =='black'
      opposite_color = 'white'
    end
    opposite_color
  end

  def verify_checkmate(color, board)
    king_coordinates = get_king_location(color, board)
    starting_piece = get_piece(king_coordinates)
    all_movements = Array.new
    impossible_movements = Array.new
    is_king_in_checkmate = false

    all_movements.push(*starting_piece.all_possible_movements(@board, king_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(@board, king_coordinates))

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(king_coordinates, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        is_king_in_checkmate = true
        impossible_movements.push(possible_end)
      end
    end
    all_movements = all_movements - impossible_movements

    unless all_movements.empty?
      is_king_in_checkmate = false
    end 
    is_king_in_checkmate
  end
end
