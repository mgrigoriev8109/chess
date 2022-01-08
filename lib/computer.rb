require_relative 'input'

class Computer
  include Input

  attr_reader :name, :color
  attr_accessor :alg_notation

  def initialize(color, name)
    @color = color
    @name = name
    @alg_notation = []
  end

  def get_input_array
    @alg_notation = [("A".."H").to_a.sample, ("0".."7").to_a.sample, ("A".."H").to_a.sample, ("0".."7").to_a.sample].join
    p @alg_notation
  end

end