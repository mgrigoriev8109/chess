# frozen_string_literal: true

require_relative 'player'
require_relative 'display'
require_relative 'pieces/rook'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/white_pawn'
require_relative 'pieces/black_pawn'
require_relative 'create_pieces'
require_relative 'castling'
require_relative 'enpassant'
require_relative 'check_checkmate'
require_relative 'computer'
require_relative 'save_load'

class CurrentGame
  include CreatePieces
  include Castling
  include EnPassant
  include CheckCheckmate
  include Computer
  include SaveLoad

  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, ' ') }
    @simulation_board = []
  end

  def display_introduction
    puts "\n\n- Enter the word 'play' to begin or 'load' to load a game if playing locally.\n\n"
    load_game if gets.chomp == 'load'
  end

  def display_instruction
    puts "\n\n- Players move pieces across the Chessboard using the notation A1B1.\n"
    puts "  In the example A1B1:\n"
    puts "  A1 will represent where the piece you wish to move is located.\n"
    puts "  B1 will represent where you want that piece to move.\n"
    puts "  To find the desired number/letter coordinates, look at the chessboard.\n"
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
    puts "\n- Who will play the color #{color}?\n"
    puts "  Type in 'computer' for this color to be played by AI\n"
    puts "  Or any other name, for example 'Robin', to play this color as a human.\n\n"
    player_name = gets.chomp
    Player.new(color, player_name)
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
    rooks_or_kings_moved?(end_location, @board)
    can_next_player_castle(color, @board)
    can_next_player_enpassant(start_location, end_location, @board)
  end

  def get_input(player)
    input = []
    while player.get_input_array
      if player.input == 'save'
        input = 'save'
        save_game
      elsif player.verify_input && verify_movement(player.movement, player.color, @board)
        input = player.movement
        break
      else
        puts "Looks like you entered an invalid input. Enter 'save' or a valid move."
        puts 'Remember that Players move pieces across the Chessboard using the notation A1B1'
        puts 'In the example A1B1, A1 will represent where your piece is located on this turn.'
        puts "In the example A1B1, B1 will represent where you want that piece to move.\n\n"
      end
    end
    input
  end

  def get_piece(coordinates)
    row = coordinates[0]
    column = coordinates[1]
    @board[row][column]
  end

  def get_king_location(color, board)
    king_location = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        king_location = [row_index, column_index] if cell.is_a?(King) && cell.color == color
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
    case current_player_color
    when 'white'
      opposite_color = 'black'
    when 'black'
      opposite_color = 'white'
    end
    opposite_color
  end

  def promote_eligible_pawns(board)
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if row_index.zero? && cell.is_a?(WhitePawn)
          board[row_index][column_index] = Queen.new('white')
          puts 'A White Pawn has been promoted to a White Queen'
        elsif row_index == 7 && cell.is_a?(BlackPawn)
          board[row_index][column_index] = Queen.new('black')
          puts 'A Black Pawn has been promoted to a Black Queen'
        end
      end
    end
  end
end
