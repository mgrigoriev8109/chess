class Display

  def initialize(gameboard)
    @gameboard = gameboard
  end 

  def show
    white_king = "♔"
    white_queen = "♕"
    white_rook = "♖"
    white_bishop = "♗"
    white_knight = "♘"
    white_pawn = "♙"
    black_king = "♚"
    black_queen = "♛"
    black_rook = "♜"
    black_bishop = "♝"
    black_knight = "♞"
    black_pawn = "♟︎" 
    puts <<-HEREDOC
          +---+---+---+---+---+---+---+---+
        8 | #{@gameboard[0][0]} | #{@gameboard[0][1]} | #{@gameboard[0][2]} | #{@gameboard[0][3]} | #{@gameboard[0][4]} | #{@gameboard[0][5]} | #{@gameboard[0][6]} | #{@gameboard[0][7]} |
          +---+---+---+---+---+---+---+---+
        7 | #{@gameboard[1][0]} | #{@gameboard[1][1]} | #{@gameboard[1][2]} | #{@gameboard[1][3]} | #{@gameboard[1][4]} | #{@gameboard[1][5]} | #{@gameboard[1][6]} | #{@gameboard[1][7]} |
          +---+---+---+---+---+---+---+---+
        6 | #{@gameboard[2][0]} | #{@gameboard[2][1]} | #{@gameboard[2][2]} | #{@gameboard[2][3]} | #{@gameboard[2][4]} | #{@gameboard[2][5]} | #{@gameboard[2][6]} | #{@gameboard[2][7]} |
          +---+---+---+---+---+---+---+---+
        5 | #{@gameboard[3][0]} | #{@gameboard[3][1]} | #{@gameboard[3][2]} | #{@gameboard[3][3]} | #{@gameboard[3][4]} | #{@gameboard[3][5]} | #{@gameboard[3][6]} | #{@gameboard[3][7]} |
          +---+---+---+---+---+---+---+---+
        4 | #{@gameboard[4][0]} | #{@gameboard[4][1]} | #{@gameboard[4][2]} | #{@gameboard[4][3]} | #{@gameboard[4][4]} | #{@gameboard[4][5]} | #{@gameboard[4][6]} | #{@gameboard[4][7]} |
          +---+---+---+---+---+---+---+---+
        3 | #{@gameboard[5][0]} | #{@gameboard[5][1]} | #{@gameboard[5][2]} | #{@gameboard[5][3]} | #{@gameboard[5][4]} | #{@gameboard[5][5]} | #{@gameboard[5][6]} | #{@gameboard[5][7]} |
          +---+---+---+---+---+---+---+---+
        2 | #{@gameboard[6][0]} | #{@gameboard[6][1]} | #{@gameboard[6][2]} | #{@gameboard[6][3]} | #{@gameboard[6][4]} | #{@gameboard[6][5]} | #{@gameboard[6][6]} | #{@gameboard[6][7]} |
          +---+---+---+---+---+---+---+---+
        1 | #{@gameboard[7][0]} | #{@gameboard[7][1]} | #{@gameboard[7][2]} | #{@gameboard[7][3]} | #{@gameboard[7][4]} | #{@gameboard[7][5]} | #{@gameboard[7][6]} | #{@gameboard[7][7]} |
          +---+---+---+---+---+---+---+---+
            A   B   C   D   E   F   G   H
    HEREDOC
  end

end