module BishopRookMovements
  def movements_down_left(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_moves = []
    column_to_check = starting_column - 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      break if piece_in_the_way

      next unless row_index > starting_row

      board_row.each_with_index do |value, column_index|
        if column_to_check == column_index && value.is_a?(Piece)
          piece_in_the_way = true
        elsif column_to_check == column_index
          possible_moves.push([row_index, column_index])
        end
      end
      column_to_check -= 1
    end
    possible_moves
  end

  def movements_up_left(board, piece_location)
    ending_row = piece_location[0]
    ending_column = piece_location[1]
    possible_moves = []
    dont_check_further = false
    column_to_check = ending_column - ending_row
    row_to_check = 0

    if ending_column < ending_row
      column_to_check = 0
      row_to_check = ending_row - ending_column
    end

    board.each_with_index do |board_row, row_index|
      break if dont_check_further

      board_row.each_with_index do |value, column_index|
        if column_to_check == ending_column && row_index >= row_to_check
          dont_check_further = true
        elsif column_to_check == column_index && value.is_a?(Piece) && row_index >= row_to_check
          possible_moves = []
          row_to_check += 1
          column_to_check += 1
        elsif column_to_check == column_index && row_index >= row_to_check
          possible_moves.push([row_index, column_index])
          row_to_check += 1
          column_to_check += 1
        end
      end
    end
    possible_moves
  end

  def movements_down_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_moves = []
    column_to_check = starting_column + 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      break if piece_in_the_way

      next unless row_index > starting_row

      board_row.each_with_index do |value, column_index|
        if column_to_check == column_index && value.is_a?(Piece)
          piece_in_the_way = true
        elsif column_to_check == column_index
          possible_moves.push([row_index, column_index])
        end
      end
      column_to_check += 1
    end
    possible_moves
  end

  def movements_up_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_moves = []
    column_to_check = starting_row + starting_column

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index|
        if column_to_check == column_index && value.is_a?(Piece) && column_index > starting_column
          possible_moves = []
          break
        elsif column_to_check == column_index && column_index > starting_column
          possible_moves.push([row_index, column_index])
        end
      end

      column_to_check -= 1
    end

    possible_moves
  end

  def row_to_look_through(board, starting_row)
    moves_to_look_through = []
    board.each_with_index do |board_row, row_index|
      moves_to_look_through = board_row if starting_row == row_index
    end
    moves_to_look_through
  end

  def column_to_look_through(board, starting_column)
    moves_to_look_through = []
    board.each_with_index do |board_row, _row_index|
      board_row.each_with_index do |value, column_index|
        moves_to_look_through.push(value) if starting_column == column_index
      end
    end
    moves_to_look_through
  end

  def movements_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    moves_to_look_through = row_to_look_through(board, starting_row)
    possible_moves = []

    moves_to_look_through.each_with_index do |value, index|
      if index > starting_column && value.is_a?(Piece)
        break
      elsif index > starting_column
        possible_moves.push([starting_row, index])
      end
    end

    possible_moves
  end

  def movements_left(board, piece_location)
    starting_row = piece_location[0]
    starting_column = 7 - piece_location[1]
    moves_to_look_through = row_to_look_through(board, starting_row)
    possible_moves = []

    moves_to_look_through.reverse.each_with_index do |value, index|
      if index > starting_column && value.is_a?(Piece)
        break
      elsif index > starting_column
        index = 7 - index
        possible_moves.push([starting_row, index])
      end
    end
    possible_moves
  end

  def movements_down(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    moves_to_look_through = column_to_look_through(board, starting_column)
    possible_moves = []

    moves_to_look_through.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Piece)
        break
      elsif index > starting_row
        possible_moves.push([index, starting_column])
      end
    end

    possible_moves
  end

  def movements_up(board, piece_location)
    starting_row = 7 - piece_location[0]
    starting_column = piece_location[1]
    moves_to_look_through = column_to_look_through(board, starting_column)
    possible_moves = []

    moves_to_look_through.reverse.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Piece)
        break
      elsif index > starting_row
        index = 7 - index
        possible_moves.push([index, starting_column])
      end
    end

    possible_moves
  end
end
