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
require_relative 'castling'
require_relative 'enpassant'
require_relative 'check_checkmate'
require_relative 'computer'

class CurrentGame
  include CreatePieces
  include Castling
  include EnPassant 
  include CheckCheckmate
  include Computer

  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @simulation_board = Array.new
  end 

  def introduction
    puts "Welcome to a CLI game of Chess!"
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

  def computer_turn(player)
    show_display
    puts "#{player.color} Computer it is now your turn."
    loop do 
      computer_movement = determine_computer_movement(player.color, @board)
      p computer_movement
      starting_location = [computer_movement[0], computer_movement[1]]
      ending_location = [computer_movement[2], computer_movement[3]]
      if possible_enpassant(starting_location) && verify_movement(computer_movement, color)
        destroy_defending_pawn(starting_location, ending_location, @board)
      elsif possible_castling(starting_location, ending_location) && verify_movement(computer_movement, player.color)
        move_castling_rook(color, starting_location, ending_location, @board)
      elsif verify_movement(computer_movement, player.color)
        break
      end
    end
    
    move_gamepiece(player.starting_location, player.ending_location, @board)
    assess_pawn_promotion(@board)

    assess_check_checkmate(player.color, @board)
    have_rooks_or_kings_moved(player.ending_location, @board)
    can_next_player_castle(player.color, @board)
    can_next_player_enpassant(player.starting_location, player.ending_location, @board)
  end

  def human_turn(player)
    show_display
    puts "#{player.name} it is now your turn."
    while player.get_input_array
      if possible_enpassant(player.starting_location) && verify_movement(player.movement, player.color)
        destroy_defending_pawn(player.starting_location, player.ending_location, @board)
      elsif possible_castling(player.starting_location, player.ending_location) && verify_movement(player.movement, player.color)
        move_castling_rook(color, player.starting_location, player.ending_location, @board)
      elsif verify_movement(player.movement, player.color)
        break
      end
    end
    
    move_gamepiece(player.starting_location, player.ending_location, @board)
    assess_pawn_promotion(@board)

    assess_check_checkmate(player.color, @board)
    have_rooks_or_kings_moved(player.ending_location, @board)
    can_next_player_castle(player.color, @board)
    can_next_player_enpassant(player.starting_location, player.ending_location, @board)
  end

  def get_piece(coordinates)
    row = coordinates[0]
    column = coordinates[1]
    starting_piece = @board[row][column]
    starting_piece
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

  def move_gamepiece(starting_location, ending_location, board)
    starting_row = starting_location[0]
    starting_column = starting_location[1]

    ending_row = ending_location[0]
    ending_column = ending_location[1]

    board[ending_row][ending_column] = @board[starting_row][starting_column]

    board[starting_row][starting_column] = ' '
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

end
