require_relative 'piece'

class Rook < Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♜"
    elsif @color == 'black'
      symbol = "♖"
    end
    symbol
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

  def all_possible_movements(board, rook_location)
    movements_array = Array.new
    movements_array.push(*movements_right(board, rook_location))
    movements_array.push(*movements_left(board, rook_location))
    movements_array.push(*movements_up(board, rook_location))
    movements_array.push(*movements_down(board, rook_location))
    movements_array.delete([])
    movements_array
  end


  def movements_right(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
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

  def movements_left(board, rook_location)
    starting_row = rook_location[0]
    starting_column = 7 - rook_location[1]
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

  def movements_down(board, rook_location)
    starting_row = rook_location[0]
    starting_column = rook_location[1]
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

  def movements_up(board, rook_location)
    starting_row = 7 - rook_location[0]
    starting_column = rook_location[1]
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
