require_relative 'player'
require_relative 'display'
require_relative 'rook'

class CurrentGame
  attr_reader :board, :display

  def initialize
    @board = Array.new(8) { Array.new(8, " ")}
    @display = create_display
  end 

  def create_display
    display = Display.new(@board)
  end 

  def create_starting_rooks
    @board[0][7] = Rook.new('white')
    @board[7][7] = Rook.new('white')
    @board[0][0] = Rook.new('black')
    @board[7][0] = Rook.new('black')
  end
  
  def rook_row_movements(rook_location)
    rook_row = rook_location[0]
    rook_column = rook_location[1]
    row_array = Array.new 
    possible_rook_moves = Array.new
    
    @board.each_with_index do |board_row, row_index|
      if rook_row == row_index
        row_array = board_row
      end
    end

    row_array.each_with_index do |value, current_column|
      if current_column > rook_column && value.is_a?(Rook)
        break
      elsif current_column > rook_column
        possible_rook_moves.push([rook_row, current_column])
      end
    end
    possible_rook_moves
  end

end

current_game = CurrentGame.new