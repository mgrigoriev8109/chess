module Castling

  def have_rooks_or_kings_moved(ending_location, board)
    piece_being_moved = get_piece(ending_location)
    if piece_being_moved.is_a?(King)
      piece_being_moved.has_moved = true
    elsif piece_being_moved.is_a?(Rook)
      piece_being_moved.has_moved = true
    end
  end
  
  def possible_castling(starting_location, ending_location)
    is_castling_possible = false
    if get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 2
      is_castling_possible = true
    elsif get_piece(starting_location).is_a?(King) && starting_location[1] == 4 && ending_location[1] == 6
      is_castling_possible = true
    end
    is_castling_possible
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
    if verify_castling_conditions(next_player_color, board, 'left')
      king_ending_coordinates = [castling_row, 2]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    elsif verify_castling_conditions(next_player_color, board, 'right')
      king_ending_coordinates = [castling_row, 6]
      king = get_piece(king_start)
      king.can_castling_coordinates = king_ending_coordinates
    end
  end

  def verify_castling_conditions(color, board, direction)
    king_location = get_king_location(color, board)
    king_piece = get_piece(king_location)
    rook_location = [king_location[0], get_rook_column(direction)]
    rook_piece = get_piece(rook_location)
    king_can_castle = true

    if king_piece.has_moved 
      king_can_castle = false
    elsif rook_has_moved(rook_piece)
      king_can_castle = false
    elsif pieces_between_king_rook(king_location, rook_location, board)
      king_can_castle = false
    elsif is_king_landing_in_check(king_location, board, direction)
      king_can_castle = false
    end
    king_can_castle
  end

  def rook_has_moved(piece_tested)
    has_rook_moved = true
    if piece_tested.is_a?(Rook) && piece_tested.has_moved
      has_rook_moved = true
    elsif  piece_tested.is_a?(Rook)
      has_rook_moved = false
    end
    has_rook_moved
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
    starting_column = [king_location[1], rook_location[1]].min
    ending_column = [king_location[1], rook_location[1]].max
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

  def is_king_landing_in_check(king_location, board, direction)
    all_movements = king_also_lands_on(king_location, direction)
    king_color = get_piece(king_location).color
    king_in_check = false
    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(king_location, possible_end, simulated_board)
      if verify_check(king_color, simulated_board) == true
        king_in_check = true
      end
    end
    king_in_check
  end

  def king_also_lands_on(king_location, direction)
    king_also_lands_on = Array.new
    first_left_location = [king_location[0],king_location[1] - 1]
    second_left_location = [king_location[0],king_location[1] - 2]
    first_right_location = [king_location[0],king_location[1] + 1]
    second_right_location = [king_location[0],king_location[1] + 2]

    if direction == 'left'
      king_also_lands_on.push(first_left_location, second_left_location)
    elsif direction == 'right'
      king_also_lands_on.push(first_right_location, second_right_location)
    end
    king_also_lands_on
  end

end
