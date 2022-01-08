require_relative 'input'

class Computer
  include input

  attr_reader :name, :color
  attr_accessor :alg_notation
  
  def initialize(color, name)
    @color = color
    @name = name
    @alg_notation = []
  end

  def get_input_array
    @alg_notation = [*"A".."H", *"0".."7", *"A".."H", *"0".."7"].sample.join
  end

end