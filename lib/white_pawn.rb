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

end
