class Player

  attr_reader :name, :color
  attr_accessor :alg_notation

  def initialize(color, name)
    @color = color
    @name = name
    @alg_notation = []
  end

  def get_input_array
    puts "Players move pieces across the Chessboard using the notation A1B1"
    puts "In the example A1B1, A1 will represent where your piece is located on this turn."
    puts "In the example A1B1, B1 will represent where you want that piece to move."
    puts "Please enter the movement you would like to make:"
    @alg_notation = gets.chomp.split("")
  end
  
end
