module Computer

  def determine_computer_movement(color, board)
    computer_movement = Array.new
    if find_computer_checkmate(color, board)
      computer_movement = find_computer_checkmate(color, board)
    elsif find_computer_check(color, board)
      computer_movement = find_computer_check(color, board)
    elsif find_computer_attack(color, board)
      computer_movement = find_computer_attack(color, board)
    elsif
      computer_movement = find_computer_move(color, board)
    end
    computer_movement
  end

  def find_computer_checkmate(color, board)
    checkmate = false
    board.each_with_index do |row, row_index|
      break if checkmate
      row.each_with_index do |cell, column_index|
        break if checkmate
        current_coordinates = [row_index, column_index]
        if cell != ' ' && cell.color == color && move_results_in_checkmate(color, current_coordinates, board)
          checkmate.push(*current_coordinates)
          checkmate.push(cell.move_results_in_checkmate(color, current_coordinates, board))
        end
      end
    end
    checkmate
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
      if verify_checkmate(color, simulated_board) == true
        move_resulting_in_checkmate = possible_end
      end
    end
    move_resulting_in_checkmate
  end

  def find_computer_check(color, board)
    check = false
    board.each_with_index do |row, row_index|
      break if check
      row.each_with_index do |cell, column_index|
        break if check
        current_coordinates = [row_index, column_index]
        if cell != ' ' && cell.color == color && move_results_in_check(color, current_coordinates, board)
          check = Array.new
          check.push(*current_coordinates)
          check.push(cell.move_results_in_check(color, current_coordinates, board))
        end
      end
    end
    check
  end

  def move_results_in_check(color, starting_coordinates, board)
    all_movements = Array.new
    starting_piece = get_piece(starting_coordinates)
    all_movements.push(*starting_piece.all_possible_movements(board, starting_coordinates))
    all_movements.push(*starting_piece.all_possible_attacks(board, starting_coordinates))
    move_resulting_in_check = false

    all_movements.each do |possible_end|
      simulated_board = Marshal.load(Marshal.dump(board))
      move_gamepiece(starting_coordinates, possible_end, simulated_board)
      if verify_check(color, simulated_board) == true
        move_resulting_in_check = possible_end
      end
    end
    move_resulting_in_check
  end

  def find_computer_attack(color, board)
    attack = false
    board.each_with_index do |row, row_index|
      break if attack
      row.each_with_index do |cell, column_index|
        break if attack
        current_coordinates = [row_index, column_index]
        if cell != ' ' && cell.color == color && cell.all_possible_attacks(current_coordinates, board).any?
          ending_coordinates = all_possible_attacks[0]
          attack = Array.new
          attack.push(*current_coordinates)
          attack.push(*ending_coordinates)
        end
      end
    end
    attack
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

end