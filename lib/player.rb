class Player

  def initialize(color, name)
    @color = color
    @name = name
    @available_pieces = generate_pieces
  end

  def create_starting_pieces
    current_rooks = Rook.new(color)
    current_rooks.create_starting_rooks
  end
end


