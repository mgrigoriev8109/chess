class Player
  def initialize(color, name)
    @color = color
    @name = name
    @available_pieces = generate_pieces
  end

  def generate_pieces
    generate_rooks
  end

  def generate_rooks
    first_rook = Rook.new(white, [0][0])
    second_rook = Rook.new(white, [0][1])
  end
end


