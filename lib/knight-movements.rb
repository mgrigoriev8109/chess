module KnightMovements
  def movements_up_right(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column + 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_up_left(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 2
    possible_column = knight_column - 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_right_up(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 1
    possible_column = knight_column + 2
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_right_down(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 1
    possible_column = knight_column + 2
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_down_right(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 2
    possible_column = knight_column + 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_down_left(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 2
    possible_column = knight_column - 1
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_left_down(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row + 1
    possible_column = knight_column - 2
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end

  def movements_left_up(board, coordinates)
    knight_row = coordinates[0]
    knight_column = coordinates[1]
    possible_row = knight_row - 1
    possible_column = knight_column - 2
    possible_move = find_possible_movement(board, possible_row, possible_column)
  end
end