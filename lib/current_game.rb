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
    @checkmate = false
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
    player = Player.new((color, player_name))
    player
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
    @board[0][2] = Bishop.new('white')
    @board[0][5] = Bishop.new('black')
    @board[7][2] = Bishop.new('white')
    @board[7][5] = Bishop.new('black')
  end

  def create_starting_kings
    @board[7][4] = Bishop.new('white')
    @board[0][4] = Bishop.new('black')
  end
  

  def play_turn(player)
    puts "#{player.name} it is now your turn."
    until verify(player.movement)
      player.get_input
    end
    move_gamepiece(player.movement)
    @checkmate = assess_checkmate
    show_display
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
          cells_attacks = cell.all_possible_attacks(board, [row_index, column_index])
          all_of_players_attacks.push(*cells_attacks)
        end
      end
    end
    all_of_players_attacks
  end

  def get_king_location(attacking_player, board)
    king_location = []

    board.each_with_index do |row, row_index|
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
    defending_king_location = get_king_location(attacking_player, board)

    if all_of_players_attacks.include?(defending_king_location)
      is_defending_king_in_check = true
    end

    is_defending_king_in_check
  end
  
  def verify_king_ending_location(king_player, other_player)
    starting_piece = get_starting_piece(king_player)
    king_movements = Array.new
    king_movements.push(*starting_piece.all_possible_movements(@board, king_player.starting_location))
    king_movements.push(*starting_piece.all_possible_attacks(@board, king_player.starting_location))

    impossible_movements = Array.new
    king_movements.each do |movement|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(king_player.starting_location, movement, simulated_board)
      if verify_check(other_player, simulated_board) == true
        impossible_movements.push(movement)
      end
    end
    king_movements = king_movements - impossible_movements

    can_piece_move_or_attack = false
    if king_movements.include?(king_player.ending_location)
      can_piece_move_or_attack = true
    end 

    can_piece_move_or_attack
  end

  def move_gamepiece(starting_location, ending_location, board)
    starting_row = starting_location[0]
    starting_column = starting_location[1]

    ending_row = ending_location[0]
    ending_column = ending_location[1]

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
