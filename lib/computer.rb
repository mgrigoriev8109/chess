module Computer

  def determine_computer_movement(color, board)
    computer_movement = Array.new
    if verify_check(color, board)
      computer_movement = find_king_escape(color, board)
    elsif find_computer_checkmate(color, board).any?
      computer_movement = find_computer_checkmate(color, board)
    elsif find_computer_check(color, board).any?
      computer_movement = find_computer_check(color, board)
    elsif find_computer_attack(color, board).any?
      computer_movement = find_computer_attack(color, board)
    elsif
      computer_movement = find_computer_move(color, board)
    end
    computer_movement
  end

  def find_computer_checkmate(color, board)
    possible_computer_movement = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color == color && move_results_in_checkmate(color, current_coordinates, board)
          possible_computer_movement = []
          ending_coordinates = move_results_in_checkmate(color, current_coordinates, board)
          possible_computer_movement.push(*current_coordinates)
          possible_computer_movement.push(*ending_coordinates)
        end
      end
    end
    possible_computer_movement
  end

  def move_results_in_checkmate(color, starting_coordinates, board)
    starting_piece = get_piece(starting_coordinates)
    all_movements = Array.new
    all_movements.push(*starting_piece.all_possible_movements(board, starting_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(board, starting_coordinates))
    move_resulting_in_checkmate = false

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(board))
      move_gamepiece(starting_coordinates, possible_end, simulated_board)
      if assess_endofround_checkmate(color, simulated_board)
        move_resulting_in_checkmate = possible_end
      end
    end
    move_resulting_in_checkmate
  end

  def find_computer_check(color, board)
    possible_computer_movement = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color == color && move_results_in_check(color, current_coordinates, board).any?
          possible_computer_movement = []
          ending_coordinates = move_results_in_check(color, current_coordinates, board)
          possible_computer_movement.push(*current_coordinates)
          possible_computer_movement.push(*ending_coordinates)
          
        end
      end
    end

    possible_computer_movement
  end

  def move_results_in_check(color, starting_coordinates, board)
    all_movements = Array.new
    starting_piece = get_piece(starting_coordinates)
    all_movements.push(*starting_piece.all_possible_movements(board, starting_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(board, starting_coordinates))
    move_resulting_in_check = []

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(board))
      move_gamepiece(starting_coordinates, possible_end, simulated_board)
      if verify_check(opposite_player_color(color), simulated_board)
        move_resulting_in_check = possible_end
      end
    end

    if starting_piece.is_a?(King)
      move_results_in_check = []
    end
    move_resulting_in_check
  end

  def find_computer_attack(color, board)
    possible_computer_movement = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color == color && cell.all_possible_attacks(board, current_coordinates).any?
          possible_computer_movement = []
          ending_coordinates = cell.all_possible_attacks(board, current_coordinates).sample
          possible_computer_movement.push(*current_coordinates)
          possible_computer_movement.push(*ending_coordinates)
        end
      end
    end
    possible_computer_movement
  end

  def find_computer_move(color, board)
    possible_computer_movement = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        current_coordinates = [row_index, column_index]
        if cell.is_a?(Piece) && cell.color == color && cell.all_possible_movements(board, current_coordinates).any?
          possible_computer_movement = []
          ending_coordinates = cell.all_possible_movements(board, current_coordinates).sample
          possible_computer_movement.push(*current_coordinates)
          possible_computer_movement.push(*ending_coordinates)
        end
      end
    end
    possible_computer_movement
  end

  def find_king_escape(color, board)
    all_movements = []
    impossible_movements = []
    king_in_check_location = get_king_location(color, board)
    king_piece = get_piece(king_in_check_location)
    all_movements.push(*king_piece.all_possible_movements(@board, king_in_check_location))
    all_movements.push(*king_piece.all_possible_attacks(@board, king_in_check_location))

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(@board))
      move_gamepiece(king_in_check_location, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        impossible_movements.push(possible_end)
      end
    end
    all_movements = all_movements - impossible_movements

    king_escape_movement = [*king_in_check_location, *all_movements.sample]
    king_escape_movement
  end
end