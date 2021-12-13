class Player

  attr_reader :name, :color
  attr_accessor :alg_notation
  def initialize(color, name)
    @color = color
    @name = name
    @alg_notation
  end

  def get_input_array
    puts "Players move pieces across the Chessboard using the notation A1B1"
    puts "In the example A1B1, A1 will represent where your piece is located on this turn."
    puts "In the example A1B1, B1 will represent where you want that piece to move."
    puts "Please enter the movement you would like to make:"
    @alg_notation = gets.chomp.split("")
  end
  
  def letter_to_numbers(letter)
    a_to_h_array = ('A'..'H').to_a
    a_to_h_array.index(letter)
  end

  def starting_location
    starting_row = letter_to_numbers(@alg_notation[0])
    starting_column = 8 - @alg_notation[1].to_i
    player_starting_location = [starting_row, starting_column]
  end

  def ending_location
    ending_row = letter_to_numbers(@alg_notation[2])
    ending_column = 8 - @alg_notation[3].to_i
    player_ending_location = [ending_row, ending_column]
  end
end
