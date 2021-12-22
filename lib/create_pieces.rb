module CreatePieces
  def create_starting_rooks
    @board[0][0] = Rook.new('black')
    @board[0][7] = Rook.new('black')
    @board[7][0] = Rook.new('white')
    @board[7][7] = Rook.new('white')
  end

  def create_starting_bishops
    @board[0][2] = Bishop.new('white')
    @board[0][5] = Bishop.new('black')
    @board[7][2] = Bishop.new('white')
    @board[7][5] = Bishop.new('black')
  end

  def create_starting_kings
    @board[7][4] = Bishop.new('white')
    @board[0][4] = Bishop.new('black')
  end
end