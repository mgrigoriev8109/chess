#spec/stale_check_mate_spec.rb
require 'current_game'

describe CurrentGame do
  describe '#verify_check' do

    subject(:current_game) {described_class.new}

    context 'When checking if the attacking Black player can perform Check on a White King piece' do

      it "returns true when Black has a Rook [0,2] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[0][2] = Rook.new('black')

        is_check_occurring = current_game.verify_check('white', current_game.board)
        
        expect(is_check_occurring).to be true
      end

      it "returns true when Black has a Bishop [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = Bishop.new('black')

        is_check_occurring = current_game.verify_check('white', current_game.board)
        
        expect(is_check_occurring).to be true
      end

      it "returns true when Black has a King [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = King.new('black')

        is_check_occurring = current_game.verify_check('white', current_game.board)
        
        expect(is_check_occurring).to be true
      end

      it "returns false when Black has a Rook [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = Rook.new('black')

        is_check_occurring = current_game.verify_check('white', current_game.board)
        
        expect(is_check_occurring).to be false
      end
    end
  end

  describe '#assess_endofround_check' do

    subject(:current_game) {described_class.new}

    context 'When checking if a color is placing the opponent in check' do

      it "returns true when White color is placing check on Black King at [0,0]" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[0][2] = Rook.new('white')
        current_player_color = 'white'

        is_opponent_in_check = current_game.assess_endofround_check(current_player_color, current_game.board)
        
        expect(is_opponent_in_check).to be true
      end

      it "returns false when White color has no check on Black King at [0,0]" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[0][1] = Rook.new('black')
        current_game.board[0][2] = Rook.new('white')
        current_player_color = 'white'

        is_opponent_in_check = current_game.assess_endofround_check(current_player_color, current_game.board)
        
        expect(is_opponent_in_check).to be false
      end      
      
      it "returns true when Black color places Check in White" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[0][1] = Rook.new('black')
        current_game.board[0][2] = Rook.new('white')
        current_game.board[5][1] = King.new('white')
        current_player_color = 'black'

        is_opponent_in_check = current_game.assess_endofround_check(current_player_color, current_game.board)
        
        expect(is_opponent_in_check).to be true
      end
    end
  end

  describe '#assess_endofround_checkmate' do

    subject(:current_game) {described_class.new}

    context 'When checking if a color is placing the opponent in checkmate' do

      it "returns true when two White Rooks placing Black King in Checkmate at [0,0]" do
        
        current_game.board[0][2] = Rook.new('white')
        current_game.board[1][2] = Rook.new('white')
        current_game.board[0][0] = King.new('black')
        current_player_color = 'white'

        is_opponent_in_checkmate = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
        
        expect(is_opponent_in_checkmate).to be true
      end

      it "returns false when two White Rooks are not placing Black King in Checkmate at [0,0]" do
        
        current_game.board[0][2] = Rook.new('white')
        current_game.board[2][2] = Rook.new('white')
        current_game.board[0][0] = King.new('black')
        current_player_color = 'white'

        is_opponent_in_checkmate = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
        
        expect(is_opponent_in_checkmate).to be false
      end
    end

    it "returns false when two White Rooks placing Black King in Check but black Rook can save King" do
        
      current_game.board[0][2] = Rook.new('white')
      current_game.board[1][2] = Rook.new('white')
      current_game.board[0][0] = King.new('black')
      current_game.board[0][3] = Rook.new('black')
      current_player_color = 'white'

      is_opponent_in_checkmate = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
      
      expect(is_opponent_in_checkmate).to be false
    end

    it "returns true when white King can't move because of three black rooks" do
        
      current_game.board[3][2] = Rook.new("black")
      current_game.board[3][5] = Rook.new("black")
      current_game.board[5][5] = Rook.new("black")
      current_game.board[4][0] = King.new("white")
      current_player_color = 'white'

      is_opponent_in_checkmate = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
      
      expect(is_opponent_in_checkmate).to be true
    end

  end

  describe '#assess_endofround_stalemate' do

    subject(:current_game) {described_class.new}

    context 'When checking if the next player to have a turn will be in a Stalemate' do

      it "returns false when game is just beginning" do
        
        current_game.populate_gameboard
        current_player_color = 'white'

        next_player_in_stalemate = current_game.assess_endofround_stalemate(current_player_color, current_game.board)
        
        expect(next_player_in_stalemate).to be false
      end

      it "returns true when it's White's turn, and White Rooks are placed so that Black King is in Stalemate" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][2] = Rook.new('white')
        current_game.board[2][1] = Rook.new('white')
        current_player_color = 'white'

        next_player_in_stalemate = current_game.assess_endofround_stalemate(current_player_color, current_game.board)
        
        expect(next_player_in_stalemate).to be true
      end
    end
  end

  describe '#can_piece_move' do

    subject(:current_game) {described_class.new}

    context 'When looking to see if a piece can move anywhere' do

      it "returns false because a black rook is blocked off and can't move anywhere" do
        
        current_game.populate_gameboard
        black_rook_coordinates = [0,0]

        can_this_piece_move = current_game.can_piece_move(current_game.board, black_rook_coordinates)
        
        expect(can_this_piece_move.any?).to be false
      end 

      it "returns true because a black pawn can move in the beginning of the game" do
        
        current_game.populate_gameboard
        black_pawn_coordinates = [1,0]

        can_this_piece_move = current_game.can_piece_move(current_game.board, black_pawn_coordinates)
        
        expect(can_this_piece_move.any?).to be true
      end

    end
  end
end