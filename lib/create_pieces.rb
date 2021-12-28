module CreatePieces
  def create_starting_rooks
    @board[0][0] = Rook.new('black')
    @board[0][7] = Rook.new('black')
    @board[7][0] = Rook.new('white')
    @board[7][7] = Rook.new('white')
  end

  def create_starting_bishops
    @board[0][2] = Bishop.new('black')
    @board[0][5] = Bishop.new('black')
    @board[7][2] = Bishop.new('white')
    @board[7][5] = Bishop.new('white')
  end

  def create_starting_kings
    @board[0][4] = King.new('black')
    @board[7][4] = King.new('white')
  end

  def create_starting_queens
    @board[0][3] = Queen.new('black')
    @board[7][3] = Queen.new('white')
  end

  def create_starting_knights
    @board[0][1] = Knight.new('black')
    @board[0][6] = Knight.new('black')
    @board[7][1] = Knight.new('white')
    @board[7][6] = Knight.new('white')
  end

  def create_starting_pawns
    @board[1][0] = BlackPawn.new('black')
    @board[1][1] = BlackPawn.new('black')
    @board[1][2] = BlackPawn.new('black')
    @board[1][3] = BlackPawn.new('black')
    @board[1][4] = BlackPawn.new('black')
    @board[1][5] = BlackPawn.new('black')
    @board[1][6] = BlackPawn.new('black')
    @board[1][7] = BlackPawn.new('black')
    @board[6][0] = WhitePawn.new('white')
    @board[6][1] = WhitePawn.new('white')
    @board[6][2] = WhitePawn.new('white')
    @board[6][3] = WhitePawn.new('white')
    @board[6][4] = WhitePawn.new('white')
    @board[6][5] = WhitePawn.new('white')
    @board[6][6] = WhitePawn.new('white')
    @board[6][7] = WhitePawn.new('white')
  end
end