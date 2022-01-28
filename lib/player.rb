class Player

  attr_reader :name, :color
  attr_accessor :alg_notation

  def initialize(color, name)
    @color = color
    @name = name
    @alg_notation = []
  end

  def get_input_array
    puts "Please enter the movement you would like to make:"
    @alg_notation = gets.chomp.split("")
  end

  def letter_to_numbers(letter)
    a_to_h_array = ('A'..'H').to_a
    a_to_h_array.index(letter)
  end

  def get_algebraic_notation(movement)
    a_to_h_array = ('A'..'H').to_a

    start_letter = a_to_h_array[movement[0]]
    end_letter = a_to_h_array[movement[2]]
    start_number = 8 - movement[1]
    end_number = 8 - movement[3]

    algebraic_notation_string = [start_letter, start_number, end_letter, end_number].join('')
  end

  def starting_location
    starting_column = letter_to_numbers(@alg_notation[0])
    starting_row = 8 - @alg_notation[1].to_i
    player_starting_location = [starting_row, starting_column]
  end

  def ending_location
    ending_column = letter_to_numbers(@alg_notation[2])
    ending_row = 8 - @alg_notation[3].to_i
    player_ending_location = [ending_row, ending_column]
  end

  def movement
    movement = Array.new
    movement.push(*starting_location)
    movement.push(*ending_location)
    movement
  end
end
