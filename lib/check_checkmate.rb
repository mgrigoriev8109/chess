module CheckCheckmate

  def verify_movement(movement, color)
    is_movement_verified = false
    starting_coordinates = [movement[0], movement[1]]
    ending_coordinates = [movement[2], movement[3]]
    is_movement_verified = verify_start(starting_coordinates, color)
    is_movement_verified = verify_end(starting_coordinates, ending_coordinates)
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

  def verify_end(starting_coordinates, ending_coordinates)
    starting_piece = get_piece(starting_coordinates)
    color = starting_piece.color
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

  def assess_endofround_checkmate(current_player_color, board)
    is_other_player_in_checkmate = false
    other_player_color = opposite_player_color(current_player_color)
    all_possible_attacks = get_all_attacks_against(other_player_color, board)
    defending_king_location = get_king_location(other_player_color, board)

    if all_possible_attacks.include?(defending_king_location) && can_king_move(other_player_color, board)
      is_other_player_in_checkmate = true
    end

    is_other_player_in_checkmate
  end

  def assess_endofround_stalemate(color, board)
    can_other_player_move = false
    is_other_player_in_stalemate = true
    board.each_with_index do |row, row_index|
      break if can_other_player_move

      row.each_with_index do |cell, column_index|
        break if can_other_player_move

        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color != color && can_player_move(current_coordinates, cell)
          can_other_player_move = true
        end
      end
    end
    if can_other_player_move
      is_other_player_in_stalemate = false
    end
    is_other_player_in_stalemate
  end

  def can_player_move(start_coordinates, cell)
    all_possible_moves = []
    all_possible_moves.push(*cell.all_possible_attacks(board, start_coordinates))
    all_possible_moves.push(*cell.all_possible_movements(board, start_coordinates))
    all_possible_moves.select! { |possible_end| verify_end(start_coordinates, possible_end) }
  end

  def can_king_move(color, board)
    king_coordinates = get_king_location(color, board)
    starting_piece = get_piece(king_coordinates)
    king_movements = Array.new
    impossible_movements = Array.new
    is_king_unable_to_move = false

    king_movements.push(*starting_piece.all_possible_movements(@board, king_coordinates))
    king_movements.push(*starting_piece.all_possible_attacks(@board, king_coordinates))

    king_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(board))
      move_gamepiece(king_coordinates, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        is_king_unable_to_move = true
        impossible_movements.push(possible_end)
      end
    end
    king_movements = king_movements - impossible_movements
    unless king_movements.empty?
      is_king_unable_to_move = false
    end 
    is_king_unable_to_move
  end
end