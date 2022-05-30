# frozen_string_literal: true

module CheckCheckmate
  def assess_endofgame(color, board)
    is_game_over = false
    if assess_endofround_checkmate(color, board)
      puts "Looks like #{color} has won and put the opposing color into Checkmate!"
      is_game_over = true
    elsif assess_endofround_check(color, board)
      puts "Looks like #{color} has put the opposing color into Check!"
    elsif assess_endofround_stalemate(color, board)
      puts "Looks like the game is over because #{color} has put the opposing color into Stalemate!"
      is_game_over = true
    end
    is_game_over
  end

  def verify_movement(movement, color, board)
    is_movement_verified = false
    starting_coordinates = [movement[0], movement[1]]
    ending_coordinates = [movement[2], movement[3]]
    is_movement_verified = verify_start(starting_coordinates, color)
    verify_end(starting_coordinates, ending_coordinates, board)
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

  def verify_end(starting_coordinates, ending_coordinates, board)
    starting_piece = get_piece(starting_coordinates)
    color = starting_piece.color
    all_movements = []
    impossible_movements = []
    can_piece_move_or_attack = false

    all_movements.push(*starting_piece.all_possible_movements(board, starting_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(board, starting_coordinates))

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(board))
      move_gamepiece(starting_coordinates, possible_end, simulated_board)
      impossible_movements.push(possible_end) if verify_check(color, simulated_board) == true
    end
    all_movements -= impossible_movements

    can_piece_move_or_attack = true if all_movements.include?(ending_coordinates)
    can_piece_move_or_attack
  end

  def verify_check(color, board)
    is_defending_king_in_check = false
    all_possible_attacks = get_all_attacks_against(color, board)
    defending_king_location = get_king_location(color, board)

    is_defending_king_in_check = true if all_possible_attacks.include?(defending_king_location)

    is_defending_king_in_check
  end

  def get_all_attacks_against(color, board)
    all_attacks = []

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

  def assess_endofround_check(current_player_color, board)
    is_other_player_in_check = false
    current_player_color

    case current_player_color
    when 'white'
      other_player_color = 'black'
      is_other_player_in_check = verify_check(other_player_color, board)
    when 'black'
      other_player_color = 'white'
      is_other_player_in_check = verify_check(other_player_color, board)
    end

    is_other_player_in_check
  end

  def assess_endofround_checkmate(current_color, board)
    is_next_player_in_checkmate = false
    next_player_color = opposite_player_color(current_color)
    enemy_attacks = get_all_attacks_against(next_player_color, board)
    defending_king_location = get_king_location(next_player_color, board)
    is_next_player_in_checkmate = true if enemy_attacks.include?(defending_king_location)

    is_next_player_in_checkmate = false if can_next_player_move(current_color, board)

    is_next_player_in_checkmate
  end

  def can_next_player_move(color, board)
    can_next_player_move = false
    board.each_with_index do |row, row_index|
      break if can_next_player_move

      row.each_with_index do |cell, column_index|
        break if can_next_player_move

        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color != color && can_piece_move(board, current_coordinates).any?
          can_next_player_move = true
        end
      end
    end
    can_next_player_move
  end

  def assess_endofround_stalemate(color, board)
    is_next_player_in_stalemate = true
    is_next_player_in_stalemate = false if can_next_player_move(color, board)
    is_next_player_in_stalemate
  end

  def can_piece_move(board, start_coordinates)
    all_possible_moves = []
    piece = get_piece(start_coordinates)
    all_possible_moves.push(*piece.all_possible_attacks(board, start_coordinates))
    all_possible_moves.push(*piece.all_possible_movements(board, start_coordinates))
    all_possible_moves.select! { |possible_end| verify_end(start_coordinates, possible_end, board) }
    all_possible_moves
  end
end
