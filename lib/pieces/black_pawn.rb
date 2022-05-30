# frozen_string_literal: true

require_relative 'piece'

class BlackPawn < Piece
  attr_reader :color
  attr_accessor :can_en_passant_column

  def initialize(_color)
    @color = 'black'
    @can_en_passant_column
  end

  def symbol
    '♙'
  end

  def all_possible_movements(board, pawn_location)
    pawn_row = pawn_location[0]
    pawn_column = pawn_location[1]
    possible_row = pawn_row + 1
    possible_moves = []
    piece_in_the_way = false

    board.each_with_index do |board_row, row_index|
      break if piece_in_the_way

      board_row.each_with_index do |value, column_index|
        if row_index == possible_row && column_index == pawn_column && value == ' '
          possible_moves.push([row_index, column_index])
        elsif pawn_row == 1 && row_index == 2 && column_index == pawn_column && value.is_a?(Piece)
          piece_in_the_way = true
        elsif pawn_row == 1 && row_index == 3 && column_index == pawn_column && value == ' '
          possible_moves.push([row_index, column_index])
        end
      end
    end
    possible_moves
  end

  def all_possible_attacks(board, pawn_location)
    pawn_row = pawn_location[0]
    pawn_column = pawn_location[1]
    possible_row = pawn_row + 1
    possible_columns = [(pawn_column + 1), (pawn_column - 1)]
    possible_attacks = []

    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index|
        if possible_row == row_index && @can_en_passant_column == column_index
          possible_attacks.push([row_index, @can_en_passant_column])
        elsif possible_row == row_index && possible_columns.include?(column_index) && value.is_a?(Piece) && value.color != @color
          possible_attacks.push([row_index, column_index])
        end
      end
    end
    possible_attacks
  end
end
