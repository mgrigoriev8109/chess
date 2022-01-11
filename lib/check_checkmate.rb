module CheckCheckmate

  def assess_check_checkmate(color, board)
    if assess_endofround_checkmate(color, @board)
      puts "Looks like #{color} has won and put the opposing player into Checkmate!"
    elsif assess_endofround_check(color, @board)
      puts "Looks like #{color} has put the opposing player into Check!"
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

  def assess_endofround_checkmate(current_player_color, board)
    is_other_player_in_check = false
    other_player_color = opposite_player_color(current_player_color)
    is_other_player_in_check = verify_checkmate(other_player_color, board)
    is_other_player_in_check
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