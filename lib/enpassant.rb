module EnPassant

  def player_performing_enpassant(start_location, end_location)
    attack_piece = get_piece(start_location)
    defending_pawn_row = start_location[0]
    defending_pawn_column = end_location[1]
    defend_piece = get_piece([defending_pawn_row, defending_pawn_column])
    enpassant_attack_occurring = false

    if attack_piece.is_a?(WhitePawn) && defend_piece.is_a?(BlackPawn) && attack_piece.can_en_passant_column
      enpassant_attack_occurring = true
      attack_piece.can_en_passant_column = nil
    elsif attack_piece.is_a?(BlackPawn) && defend_piece.is_a?(WhitePawn) && attack_piece.can_en_passant_column
      enpassant_attack_occurring = true
      attack_piece.can_en_passant_column = nil
    end
    enpassant_attack_occurring
  end


  def destroy_defending_pawn(starting_location, ending_location, board)
    defending_pawn_row = starting_location[0]
    defending_pawn_column = ending_location[1]
    board[defending_pawn_row][defending_pawn_column] = ' '
  end


  def can_next_player_enpassant(starting_coordinates, ending_coordinates, board)
    piece = get_piece(ending_coordinates)
    starting_row = starting_coordinates[0]
    ending_row = ending_coordinates[0]

    if piece.is_a?(WhitePawn) && starting_row == 6 && ending_row == 4 
      are_black_pawns_adjecent(ending_coordinates, board)
    elsif piece.is_a?(BlackPawn) && starting_row == 1 && ending_row == 3
      are_white_pawns_adjecent(ending_coordinates, board)
    end
  end

  def are_white_pawns_adjecent(ending_location, board)
    black_pawn_column = ending_location[1]
    white_pawn_columns = [(black_pawn_column - 1), (black_pawn_column + 1)]

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if row_index == 3 && white_pawn_columns.include?(column_index) && cell.is_a?(WhitePawn)
          cell.can_en_passant_column = black_pawn_column
        end
      end
    end

  end

  def are_black_pawns_adjecent(ending_location, board)
    white_pawn_column = ending_location[1]
    black_pawn_columns = [(white_pawn_column - 1), (white_pawn_column + 1)]

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if row_index == 4 && black_pawn_columns.include?(column_index) && cell.is_a?(BlackPawn)
          cell.can_en_passant_column = white_pawn_column
        end
      end
    end
  end
end