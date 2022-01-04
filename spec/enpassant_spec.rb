#spec/enpassant_spec.rb
require 'current_game'

describe CurrentGame do

  describe '#verify_enpassant_by_white_pawn' do

    subject(:current_game) {described_class.new}

    context 'When verifying if a White Pawn can perform En Passant attack on Black Pawn' do

      it "returns the White Pawn's @can_en_passant_column to be the adjacent Black Pawn's column when En Passant possible" do
        
        current_game.board[1][1] = BlackPawn.new('black')
        current_game.board[3][0] = WhitePawn.new('white')
        white_pawn = current_game.board[3][0]
        black_pawn_ending_location = [3,1]

        current_game.verify_enpassant_by_white_pawn(black_pawn_ending_location, current_game.board)


        expect(white_pawn.can_en_passant_column).to eq(1)
      end

      it "returns the White Pawn's @can_en_passant_column to be nil when White Pawn not adjescent, and En Passant not possible" do
        
        current_game.board[1][1] = BlackPawn.new('black')
        current_game.board[3][3] = WhitePawn.new('white')
        white_pawn = current_game.board[3][3]
        black_pawn_ending_location = [3,1]

        current_game.verify_enpassant_by_white_pawn(black_pawn_ending_location, current_game.board)


        expect(white_pawn.can_en_passant_column).to eq(nil)
      end
    end
  end

  describe '#verify_enpassant_by_black_pawn' do

    subject(:current_game) {described_class.new}

    context 'When verifying if a Black Pawn can perform En Passant attack on White Pawn' do

      it "returns the Black Pawn's @can_en_passant_column to be the adjacent White Pawn's column when En Passant possible" do
        
        current_game.board[6][7] = WhitePawn.new('white')
        current_game.board[4][6] = BlackPawn.new('black')
        black_pawn = current_game.board[4][6]
        white_pawn_ending_location = [4,7]

        current_game.verify_enpassant_by_black_pawn(white_pawn_ending_location, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(7)
      end

      it "returns the Black Pawn's @can_en_passant_column to be nil when White Pawn not adjescent, and En Passant not possible" do
        
        current_game.board[6][7] = WhitePawn.new('white')
        current_game.board[4][0] = BlackPawn.new('black')
        black_pawn = current_game.board[4][0]
        white_pawn_ending_location = [4,7]

        current_game.verify_enpassant_by_black_pawn(white_pawn_ending_location, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(nil)
      end
    end
  end

  describe '#can_next_player_enpassant' do

    subject(:current_game) {described_class.new}

    context 'Assesses if En Passant attack is possible and modifies proper pawn @can_en_passant_column variable' do

      it "returns the Black Pawn's @can_en_passant_column to be the adjacent White Pawn's column when En Passant possible" do
        
        current_game.board[6][7] = WhitePawn.new('white')
        current_game.board[4][6] = BlackPawn.new('black')
        black_pawn = current_game.board[4][6]
        starting = [6,7]
        ending = [4,7]

        current_game.can_next_player_enpassant(starting, ending, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(7)
      end

      it "returns the Black Pawn's @can_en_passant_column to be nil when White Pawn only moves 1 space and En Passant not possible" do
        
        current_game.board[5][7] = WhitePawn.new('white')
        current_game.board[4][6] = BlackPawn.new('black')
        black_pawn = current_game.board[4][6]
        starting = [5,7]
        ending = [4,7]

        current_game.can_next_player_enpassant(starting, ending, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(nil)
      end
    end
  end
end