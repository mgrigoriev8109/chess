module Castling
  def assess_castling(color, starting_location, board)
    move_castling_rook(color, board)
    can_next_player_castle(color, board)
    assess_has_king_moved(starting_location, board)
    assess_has_rook_moved(starting_location, board)
  end

  def move_castling_rook(color, starting_location, ending_location, board)
    if get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 2
      move_castling_rook_left(color, board)
    elsif get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 6
      move_castling_rook_right(color, board)
    end
  end

  def move_castling_rook_left(color, board)
    king_start = get_king_location(color, board)
    castling_row = king_start[0]
    rook_start = [castling_row, 0]
    rook_end = [castling_row, 3]
    move_gamepiece(rook_start, rook_end, board)
  end

  def move_castling_rook_right(color, board)
    king_start = get_king_location(color, board)
    castling_row = king_start[0]
    rook_start = [castling_row, 7]
    rook_end = [castling_row, 5]
    move_gamepiece(rook_start, rook_end, board)
  end

  def can_next_player_castle(color, board)
    next_player_color = opposite_player_color(color)
    king_start = get_king_location(next_player_color, board)
    castling_row = king_start[0]
    if player_can_castle_left(next_player_color, board)
      king_ending_coordinates = [castling_row, 2]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    elsif player_can_castle_right(next_player_color, board)
      king_ending_coordinates = [castling_row, 6]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    end
  end

  def player_can_castle_left(color, board)
    king_location = get_king_location(color, board)
    king_piece = get_piece(king_location)
    rook_location = [king_location[0], 0]
    rook_piece = get_piece(rook_location)
    king_can_castle_left = true
    if king_piece.has_moved 
      king_can_castle_left = false
    elsif rook_piece.has_moved
      king_can_castle_left = false
    elsif pieces_between_king_rook(color, board)
      king_can_castle_left = false
    elsif king_ends_in_check(color, board)
      king_can_castle_left = false
    end
    king_can_castle_left
  end

  def player_can_castle_right(color, board)
    king_location = get_king_location(color, board)
    king_piece = get_piece(king_location)
    rook_location = [king_location[0], 7]
    rook_piece = get_piece(rook_location)
    king_can_castle_right = true
    if king_piece.has_moved 
      king_can_castle_right = false
    elsif rook_piece.has_moved
      king_can_castle_right = false
    elsif pieces_between_king_rook(color, board)
      king_can_castle_right = false
    elsif king_ends_in_check(color, board)
      king_can_castle_right = false
    end
    king_can_castle_right
    #if king has not moved during game, rook has not moved during game
    #if there are no pieces between king and rook
    #if king is not in check
    #if king will not be in check on any of the other two squares
  end

  def pieces_between_king_rook(color, board)

  end

  def king_ends_in_check(color, board)

  end
  
  def assess_has_king_moved(starting_location, board)
    piece_being_moved = get_piece(starting_location)
    if piece_being_moved.is_a?(King)
      piece_being_moved.has_moved = true
    end
  end

  def assess_has_rook_moved(starting_location, board)
    piece_being_moved = get_piece(starting_location)
    if piece_being_moved.is_a?(Rook)
      piece_being_moved.has_moved = true
    end
  end
end
