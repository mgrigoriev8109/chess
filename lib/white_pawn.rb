require_relative 'piece'

class WhitePawn < Piece
  attr_reader :color

  def initialize(color)
    @color = 'white'
  end

  def symbol
    symbol = "♟︎"
    symbol
  end

  def movements(board, pawn_location)
    pawn_row = pawn_location[0]
    pawn_column = pawn_location[1]
    possible_row = pawn_row - 1
    possible_moves = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if row_index == possible_row && column_index == pawn_column && value == ' '
          possible_moves.push([row_index, column_index])
        elsif pawn_row == 6 && row_index == 4 && column_index == pawn_column && value == ' '
          possible_moves.push([row_index, column_index])
        elsif pawn_row == 6 && row_index == 5 && column_index == pawn_column && value.is_a?(Piece)
          possible_moves = []
        end
      end
    end
    possible_moves
  end

  def attacks(board, pawn_location)
    pawn_row = pawn_location[0]
    pawn_column = pawn_location[1]
    possible_row = pawn_row - 1
    possible_columns = [(pawn_column + 1), (pawn_column - 1)]
    possible_attacks = Array.new

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if possible_row == row_index && possible_columns.include?(column_index) && value.is_a?(Piece) && value.color != @color
          possible_attacks.push([row_index, column_index])
        end
      end
    end
    possible_attacks
  end
end

#how and where do we check for en passant

#en passant can only occur when white pawn is at row_index == 3
#and it's only possible when a Black Pawn is located at row_index == 3 and 
#  in the last turn made a two-space-movement

#this is something the CurrentGame would have to keep track of, because pieces don't keep
#track of the movements that other pieces make

#so the CurrentGame would have to each round tell the WhitePawn whether or not en_passant_possible

#this can be an instance variable that's default false

#maybe it can occur in the CurrentGame's #play_turn right after assess_checkmate

