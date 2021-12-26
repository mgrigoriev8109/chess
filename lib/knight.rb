require_relative 'piece'
require 'knight-movements'
require 'knight-attacks'

class Knight < Piece
  include KnightMovements
  include KnightAttacks

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def symbol
    if @color == 'white'
      symbol = "♞"
    elsif @color == 'black'
      symbol = "♘"
    end
    symbol
  end 

  def find_possible_movement(board, possible_row, possible_column)
    possible_move = Array.new
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if row_index == possible_row && column_index == possible_column && value == ' '
          possible_move.push([row_index, column_index])
        end
      end
    end
    possible_move
  end

  def find_possible_attack(board, possible_row, possible_column)
    possible_attack = Array.new
    board.each_with_index do |board_row, row_index|
      board_row.each_with_index do |value, column_index| 
        if row_index == possible_row && column_index == possible_column && value.is_a?(Piece) && value.color != @color
          possible_attack.push([row_index, column_index])
        end
      end
    end
    possible_attack
  end
end