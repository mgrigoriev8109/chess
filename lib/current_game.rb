require_relative 'player'
require_relative 'display'
require_relative 'rook'
require_relative 'king'
require_relative 'bishop'
require 'create_pieces'

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
    puts "What are the names of the two players playing this game?"
  end

  def populate_gameboard
    create_starting_rooks
    create_starting_bishops
    create_starting_kings
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
    puts "#{player.name} it is now your turn."
    until verify_movement(player.movement, player.color)
      player.get_input
    end
    move_gamepiece(player.starting_location, player.ending_location, @board)

    if assess_endofround_checkmate(player.color)
      puts "Looks like #{player.name} has won and put the opposing player into Checkmate!"
    elsif assess_endofround_check(player.color)
      puts "Looks like #{player.name} has put the opposing player into Check!"
    end

    assess_endofround_enpassant(player.starting_location, player.ending_location, @board)
      
    show_display
  end

  def assess_endofround_enpassant(starting_location, ending_location, board)
    starting_piece = get_piece(starting_location)
    ending_row = ending_location[0]
    ending_column = ending_location[1]

    if starting_piece.is_a?(WhitePawn)
      verify_enpassant_by_black_pawn(ending_location)
    elsif starting_piece.is_a?(BlackPawn
      verify_enpassant_by_white_pawn(ending_location)
    end

  end

  def verify_enpassant_by_white_pawn(ending_location)
    black_pawn_column = ending_location[1]
    white_pawn_row = ending_location[0] - 1
    white_pawn_columns = [(ending_location[1] - 1), (ending_location[1] + 1)

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if white_pawn_row == row_index && white_pawn_columns.include?(column_index) && cell.is_a?(WhitePawn)
          cell.can_en_passant_column = black_pawn_column
        end
      end
    end
  end

  def verify_enpassant_by_black_pawn(ending_location)
    white_pawn_column = ending_location[1]
    black_pawn_row = ending_location[0] + 1
    black_pawn_columns = [(ending_location[1] - 1), (ending_location[1] + 1)

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if black_pawn_row == row_index && black_pawn_columns.include?(column_index) && cell.is_a?(BlackPawn)
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
        impossible_movements.push(possible_end)
      end
    end
    all_movements = all_movements - impossible_movements

    if all_movements.empty?
      is_king_in_checkmate = true
    end 
    is_king_in_checkmate
  end
end
