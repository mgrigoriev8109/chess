module Castling
  def assess_castling(color, starting_location, board)
    move_castling_rook(color,starting_location, ending_location, board)
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
  
  def can_next_player_castle(color, board)
    next_player_color = opposite_player_color(color)
    king_start = get_king_location(next_player_color, board)
    castling_row = king_start[0]
    if player_can_castle(next_player_color, board, 'left')
      king_ending_coordinates = [castling_row, 2]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    elsif player_can_castle(next_player_color, board, 'right')
      king_ending_coordinates = [castling_row, 6]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    end
  end

  def player_can_castle(color, board, direction)
    king_location = get_king_location(color, board)
    king_piece = get_piece(king_location)
    rook_location = [king_location[0], get_rook_column(direction)]
    rook_piece = get_piece(rook_location)
    king_can_castle = true

    if king_piece.has_moved 
      king_can_castle = false
    elsif rook_piece.has_moved
      king_can_castle = false
    elsif pieces_between_king_rook(king_location, rook_location, board)
      king_can_castle = false
    elsif king_ends_in_check(color, board, direction)
      king_can_castle = false
    end
    king_can_castle
  end

  def get_rook_column(direction)
    rook_column = 0
    if direction == 'left'
      rook_column = 0
    elsif direction == 'right'
      rook_column = 7
    end
    rook_column
  end

  def pieces_between_king_rook(king_location, rook_location, board)
    castling_row = king_location[0]
    starting_column = [king_location[1], rook_location[1]].max
    ending_column = [king_location[1], rook_location[1]].min
    pieces_between = false
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if row_index == castling_row && column_index > starting_column && column_index < ending_column && cell != ' '
          pieces_between = true
        end
      end
    end
    pieces_between
  end

  def king_ends_in_check(color, board, direction)
    all_movements = possible_check_movements(king_location)
    is_king_in_check = false
    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(king_location, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        is_king_in_check = true
      end
    end
    is_king_in_check
  end

  def possible_check_movements(king_location)
    possible_check_movements = Array.new
    first_left_location = [king_location[0],king_location[1] - 1]
    second_left_location = [king_location[0],king_location[1] - 2]
    first_right_location = [king_location[0],king_location[1] + 1]
    second_right_location = [king_location[0],king_location[1] + 2]

    if direction == 'left'
      possible_check_movements.push(first_left_location, second_left_location)
    elsif direction == 'right'
      possible_check_movements.push(first_right_location, second_right_location)
    end
    possible_check_movements
  end

end
