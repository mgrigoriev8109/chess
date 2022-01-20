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

  def play_turn(movement)
    start_location = [movement[0], movement[1]]
    end_location = [movement[2], movement[3]]
    color = get_piece(start_location).color

    if player_performing_enpassant(start_location, end_location)
      destroy_defending_pawn(start_location, end_location, @board)
    elsif player_performing_castling(start_location, end_location)
      move_castling_rook(color, start_location, end_location, @board)
    end
    
    move_gamepiece(start_location, end_location, @board)
    promote_eligible_pawns(@board)
    have_rooks_or_kings_moved(end_location, @board)
    can_next_player_castle(color, @board)
    can_next_player_enpassant(start_location, end_location, @board)
    show_display
  end

  def get_input(player)
    while player.get_input_array
      break if verify_movement(player.movement, player.color, @board)
    end
    player.movement
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

  def promote_eligible_pawns(board)
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
