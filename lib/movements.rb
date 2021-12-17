module Movements

  def movements_down_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_moves = Array.new
    column_to_check = starting_column + 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      if piece_in_the_way
        break
      end

      if row_index > starting_row
        board_row.each_with_index do |value, column_index| 
          if column_to_check == column_index && value.is_a?(Piece) 
            piece_in_the_way = true
          elsif column_to_check == column_index
            possible_moves.push([row_index, column_index])
          end
        end
        column_to_check += 1
      end
    end
    possible_moves
  end

  def movements_up_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_moves = Array.new
    column_to_check = starting_row + starting_column

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if column_to_check == column_index && value.is_a?(Piece) && column_index > starting_column
          possible_moves = Array.new
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
    moves_to_look_through = Array.new     
    board.each_with_index do |board_row, row_index|
      if starting_row == row_index
        moves_to_look_through = board_row
      end
    end
    moves_to_look_through
  end

  def column_to_look_through(board, starting_column)
    moves_to_look_through = Array.new 
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if starting_column == column_index
          moves_to_look_through.push(value)
        end
      end
    end
    moves_to_look_through
  end

  def movements_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    moves_to_look_through = row_to_look_through(board, starting_row)
    possible_moves = Array.new

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
    possible_moves = Array.new

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
    possible_moves = Array.new

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
    possible_moves = Array.new

    moves_to_look_through.reverse.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Piece)
        break
      elsif index > starting_row
        index = index - 7
        possible_moves.push([index, starting_column])
      end
    end

    possible_moves
  end
end