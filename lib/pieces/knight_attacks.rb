module KnightAttacks
  def attacks_up_right(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column + 1
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_up_left(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column - 1
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_right_up(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 1
    possible_column = knight_column + 2
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_right_down(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 1
    possible_column = knight_column + 2
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_down_right(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 2
    possible_column = knight_column + 1
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_down_left(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 2
    possible_column = knight_column - 1
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_left_down(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 1
    possible_column = knight_column - 2
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end

  def attacks_left_up(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 1
    possible_column = knight_column - 2
    possible_move = find_possible_attack(board, possible_row, possible_column)
  end
end
