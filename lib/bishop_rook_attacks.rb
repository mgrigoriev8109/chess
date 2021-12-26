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
    ending_row = piece_location[0]
    ending_column = piece_location[1]
    possible_attack = Array.new
    dont_check_further = false
    column_to_check = ending_column - ending_row
    row_to_check = 0

    if ending_column < ending_row
      column_to_check = 0
      row_to_check = ending_row - ending_column
    end

    board.each_with_index do |board_row, row_index|
      if dont_check_further
        break
      end
      
      board_row.each_with_index do |value, column_index| 
        if column_to_check == ending_column && row_index >= row_to_check
          dont_check_further = true
        elsif column_to_check == column_index && row_index >= row_to_check && value.is_a?(Piece) && value.color != @color
          possible_attack = Array.new
          possible_attack.push([row_index, column_index])
          row_to_check += 1
          column_to_check += 1
        elsif column_to_check == column_index && row_index >= row_to_check && value.is_a?(Piece) && value.color == @color
          possible_attack = Array.new
          row_to_check += 1
          column_to_check += 1
        end
      end

    end
    possible_attack
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