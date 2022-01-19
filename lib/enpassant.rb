module EnPassant

  def possible_enpassant(starting_location)
    attacking_piece = get_piece(starting_location)
    p attacking_piece
    enpassant_attack_can_occur = false
    if attacking_piece.is_a?(WhitePawn) && attacking_piece.can_en_passant_column
      enpassant_attack_can_occur = true
    elsif attacking_piece.is_a?(BlackPawn) && attacking_piece.can_en_passant_column
      enpassant_attack_can_occur = true
    end
    enpassant_attack_can_occur
  end


  def destroy_defending_pawn(starting_location, ending_location, board)
    defending_pawn_row = starting_location[0]
    defending_pawn_column = ending_location[1]
    board[defending_pawn_row][defending_pawn_column] = ' '
  end


  def can_next_player_enpassant(starting_coordinates, ending_coordinates, board)
    starting_piece = get_piece(starting_coordinates)
    starting_row = starting_coordinates[0]
    ending_row = ending_coordinates[0]

    if starting_piece.is_a?(WhitePawn) && starting_row == 6 && ending_row == 4 
      verify_enpassant_by_black_pawn(ending_coordinates, board)
    elsif starting_piece.is_a?(BlackPawn) && starting_row == 1 && ending_row == 3
      verify_enpassant_by_white_pawn(ending_coordinates, board)
    end
  end

  def verify_enpassant_by_white_pawn(ending_location, board)
    black_pawn_column = ending_location[1]
    white_pawn_row = ending_location[0]
    white_pawn_columns = [(black_pawn_column - 1), (black_pawn_column + 1)]

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if white_pawn_row == 3 && white_pawn_columns.include?(column_index) && cell.is_a?(WhitePawn)
          cell.can_en_passant_column = black_pawn_column
          puts "The next player can perform an En Passant attack."
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
          puts "The next player can perform an En Passant attack."
        end
      end
    end
  end
end