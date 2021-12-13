class Player

  def initialize(color, name)
    @color = color
    @name = name
  end

  def get_input
    puts "Players move pieces across the Chessboard using the notation A1B1"
    puts "In the example A1B1, A1 will represent where your piece is located on this turn."
    puts "In the example A1B1, B1 will represent where you want that piece to move."
    puts "Please enter the movement you would like to make:"
    player_input = gets.chomp
    player_input
  end
  
  def verify_input
    p get_input
  end
end
