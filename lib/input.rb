module Input 

  def letter_to_numbers(letter)
    a_to_h_array = ('A'..'H').to_a
    a_to_h_array.index(letter)
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