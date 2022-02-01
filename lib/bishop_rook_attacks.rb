module BishopRookAttacks

  def attacks_up(board, rook_location)
    starting_row = 7 - rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = column_to_look_through(board, starting_column)
    possible_attack = Array.new
  
    attacks_to_look_through.reverse.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Piece) && value.color == @color
        break
      elsif index > starting_row && value.is_a?(Piece) && value.color != @color
        index = 7 - index
        possible_attack.push([index, starting_column])
        break
      end
    end
    
    possible_attack
  end

  def attacks_down(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = column_to_look_through(board, starting_column)
    possible_attack = Array.new
  
    attacks_to_look_through.each_with_index do |value, index|
      if index > starting_row && value.is_a?(Piece) && value.color == @color
        break
      elsif index > starting_row && value.is_a?(Piece) && value.color != @color
        possible_attack.push([index, starting_column])
        break
      end
    end
    
    possible_attack
  end

  def attacks_right(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
    attacks_to_look_through = row_to_look_through(board, starting_row)
    possible_attack = Array.new
  
    attacks_to_look_through.each_with_index do |value, index|
      if index > starting_column && value.is_a?(Piece) && value.color == @color
        break
      elsif index > starting_column && value.is_a?(Piece) && value.color != @color
        possible_attack.push([starting_row, index])
        break
      end
    end
    
    possible_attack
  end

  def attacks_left(board, rook_location)
    starting_row = rook_location[0]
    starting_column = 7 - rook_location[1]
    attacks_to_look_through = row_to_look_through(board, starting_row)
    possible_attacks = Array.new

    attacks_to_look_through.reverse.each_with_index do |value, index|
      if index > starting_column && value.is_a?(Piece) && value.color == @color
        break
      elsif index > starting_column && value.is_a?(Piece) && value.color != @color
        index = 7 - index
        possible_attacks.push([starting_row, index])
        break
      end
    end
    possible_attacks
  end
  
  def attacks_up_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new
    column_to_check = starting_row + starting_column

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if column_to_check == column_index && value.is_a?(Piece) && column_index > starting_column && value.color != @color
          possible_attack = Array.new
          possible_attack.push([row_index, column_index])
        elsif column_to_check == column_index&& value.is_a?(Piece) && column_index > starting_column && value.color == @color
          possible_attack = Array.new
        end
      end

      column_to_check -= 1
    end

    possible_attack
  end

  def attacks_down_right(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new
    column_to_check = starting_column + 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      if piece_in_the_way
        break
      end

      if row_index > starting_row
        board_row.each_with_index do |value, column_index| 
          if column_to_check == column_index && value.is_a?(Piece) && value.color != @color
            piece_in_the_way = true
            possible_attack.push([row_index, column_index])
          elsif column_to_check == column_index && value.is_a?(Piece) && value.color == @color
            piece_in_the_way = true
          end
        end
        column_to_check += 1
      end
    end
    possible_attack
  end

  def attacks_up_left(board, piece_location)
    possible_attack = []
    diagonal_locations = find_diagonal_locations(piece_location)
    stop_looking = false

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        current_location = [row_index, column_index]
        break if stop_looking
        if current_location == piece_location
          stop_looking = true
        elsif cell.is_a?(Piece) && cell.color != @color && diagonal_locations.include?(current_location)
          possible_attack = []
          possible_attack.push(current_location)
        elsif cell.is_a?(Piece) && cell.color == @color && diagonal_locations.include?(current_location)
          possible_attack = []
        end
      end
      
    end
    possible_attack
  end

  def find_diagonal_locations(piece_location)
    piece_row = piece_location[0]
    piece_column = piece_location[1]
    possible_diagonal_locations = []

    until (piece_row == 0) || (piece_column == 0) do
      piece_row -= 1
      piece_column -= 1
      possible_diagonal_locations.push([piece_row, piece_column])
    end 
    possible_diagonal_locations
  end

  def attacks_down_left(board, piece_location)
    starting_row = piece_location[0]
    starting_column = piece_location[1]
    possible_attack = Array.new
    column_to_check = starting_column - 1
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      if piece_in_the_way
        break
      end

      if row_index > starting_row
        board_row.each_with_index do |value, column_index| 
          if column_to_check == column_index && value.is_a?(Piece) && value.color == @color
            piece_in_the_way = true
          elsif column_to_check == column_index && value.is_a?(Piece) && value.color != @color
            possible_attack.push([row_index, column_index])
            piece_in_the_way = true
          end
        end
        column_to_check -= 1
      end
    end
    possible_attack
  end
end