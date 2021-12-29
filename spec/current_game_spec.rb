#spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'rook'
require 'king'
require 'bishop'

describe CurrentGame do

  describe '#create_starting_rooks' do

    subject(:current_game) {described_class.new}
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do

      it "returns true when an instance of Rook exists on that coordinate" do
        current_game.create_starting_rooks
        expect(current_game.board[0][0]).to be_a Rook
      end

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_a Rook
      end
    end
  end

  describe '#verify_movement' do

    subject(:current_game) {described_class.new}

    context 'When verifying that a piece of a color can make a certain movement' do

      it "returns false with movement [1,0,1,1] moving Black Rook from [1][0] to [1][1] placing Black King in Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        movement = [1,0,1,1]
        color = 'black'

        is_movement_legal = current_game.verify_movement(movement, color)
        
        expect(is_movement_legal).to be false
      end

      it "returns true with movement [6,0,4,0] moving White Pawn from start up two spaces" do
        
        current_game.board[6][0] = WhitePawn.new('white')
        movement = [6,0,4,0]
        color = 'white'

        is_movement_legal = current_game.verify_movement(movement, color)
        
        expect(is_movement_legal).to be true
      end
    end
  end

  describe '#verify_start' do

    subject(:current_game) {described_class.new}

    context 'When verifying a piece has a certain color at certain starting coordinates' do

      it "returns false if the no pieces have been created on the board" do

        current_game.board[0][0] = " "
        starting_coordinates = [0,0]
        color = 'white'

        is_start_verified = current_game.verify_start(starting_coordinates, color)

        expect(is_start_verified).to be false
      end

      it "returns false if the White Rook at [0,0] was created, and then deleted" do

        current_game.board[0][0] = Rook.new('white')
        current_game.board[0][0] = " "
        starting_coordinates = [0,0]
        color = 'white'

        is_start_verified = current_game.verify_start(starting_coordinates, color)
        
        expect(is_start_verified).to be false
      end

      it "returns true if looking for black piece at [0,0] and a Black Rook exists there" do

        current_game.board[0][0] = Rook.new('black')
        starting_coordinates = [0,0]
        color = 'black'

        is_start_verified = current_game.verify_start(starting_coordinates, color)
        
        expect(is_start_verified).to be true
      end
      
      it "returns false if looking for a black piece at [0,0] and a White Rook exists there" do

        current_game.board[0][0] = Rook.new('white')
        starting_coordinates = [0,0]
        color = 'black'

        is_start_verified = current_game.verify_start(starting_coordinates, color)
        
        expect(is_start_verified).to be false
      end
    end
  end

  describe '#verify_end' do

    subject(:current_game) {described_class.new}

    context 'When player verifying if move legal or will cause him/her to go into check' do

      it "returns false moving Black King from [0][0] to [1][0] where White Rook can attack" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('white')
        current_game.board[1][1] = Rook.new('white')
        start_coord = [0,0]
        end_coord = [1,0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, 'black')
        
        expect(is_ending_coordinate_legal).to be false
      end

      it "returns true moving Black King from [0][0] to attack White Rook at [1][0] to escape from a check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('white')
        start_coord = [0,0]
        end_coord = [1,0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, 'black')
        
        expect(is_ending_coordinate_legal).to be true
      end

      it "will return false when moving a Black Rook from [1][0] to [1][1] placing King in Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,0]
        end_coord = [1,1]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, 'black')
        
        expect(is_ending_coordinate_legal).to be false
      end
      
      it "will return false when moving a Black Rook from [1][0] to attack White Rook at [1][4] placing King in Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[1][4] = Rook.new('white')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,0]
        end_coord = [1,4]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, 'black')
        
        expect(is_ending_coordinate_legal).to be false
      end
            
      it "will return true when moving a Black Rook from [1][1] to [1][0] to move King out of Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][1] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,1]
        end_coord = [1,0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, 'black')
        
        expect(is_ending_coordinate_legal).to be true
      end
      
    end
  end

  describe '#get_piece' do

    subject(:current_game) {described_class.new}

    context 'When trying to retrieve the gamepiece from a given coordinate' do

      it "returns from a Black King located at [0,0]" do
        
        current_game.board[0][0] = King.new('black')

        piece = current_game.get_piece([0,0])
        
        expect(piece).to be_a(King)
      end
    end
  end  

  describe '#move_gamepiece' do

    let(:player){instance_double(Player, color: 'white', name: 'player', starting_location: [0,0], ending_location: [1,0]) } 
    subject(:current_game) {described_class.new}

    context 'When moving a Black Rook from A8, aka [0,0] aka [0][0]' do

      it "the board will return a Black Rook at A7, aka [1.0], aka [1][0]" do
        
        current_game.board[0][0] = Rook.new('black')
        starting_location = [0,0]
        ending_location = [1,0]

        current_game.move_gamepiece(starting_location, ending_location, current_game.board)
        ending_coordinates = current_game.board[1][0]
        
        expect(ending_coordinates).to be_a Rook
      end

      it "and also return empty space ' ' at [0][0]" do

        current_game.board[0][0] = Rook.new('black')
        starting_location = [0,0]
        ending_location = [1,0]

        current_game.move_gamepiece(starting_location, ending_location, current_game.board)
        starting_coordinates = current_game.board[0][0]
        
        expect(starting_coordinates).to eq(' ')
      end
    end
  end

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

  describe '#get_all_attacks_against' do

    subject(:current_game) {described_class.new}

    context 'When getting array of all the possible attack coordinates against a player' do

      it "returns [[0,0], [2,2]] because the white rook at [0,2] can attack the two black pieces" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[0][2] = Rook.new('white')
        current_game.board[2][2] = Bishop.new('black')
        current_game.board[3][3] = Bishop.new('black')
        current_game.board[0][5] = King.new('white')

        all_attacks_against_black = current_game.get_all_attacks_against('black', current_game.board)
        
        expect(all_attacks_against_black).to eq([[0,0], [2,2]])
      end
    end
  end  

  describe '#get_king_location' do

    subject(:current_game) {described_class.new}

    context 'When looking for the black player king' do

      it "returns the location at [0,0]" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[0][2] = Rook.new('black')
        current_game.board[0][3] = King.new('white')

        black_king_location = current_game.get_king_location('black', current_game.board)
        
        expect(black_king_location).to eq([0,0])
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

        is_opponent_in_check = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
        
        expect(is_opponent_in_check).to be true
      end

      it "returns false when two White Rooks are not placing Black King in Checkmate at [0,0]" do
        
        current_game.board[0][2] = Rook.new('white')
        current_game.board[2][2] = Rook.new('white')
        current_game.board[0][0] = King.new('black')
        current_player_color = 'white'

        is_opponent_in_check = current_game.assess_endofround_checkmate(current_player_color, current_game.board)
        
        expect(is_opponent_in_check).to be false
      end
    end
  end

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

  describe '#assess_endofround_enpassant' do

    subject(:current_game) {described_class.new}

    context 'Assesses if En Passant attack is possible and modifies proper pawn @can_en_passant_column variable' do

      it "returns the Black Pawn's @can_en_passant_column to be the adjacent White Pawn's column when En Passant possible" do
        
        current_game.board[6][7] = WhitePawn.new('white')
        current_game.board[4][6] = BlackPawn.new('black')
        black_pawn = current_game.board[4][6]
        starting = [6,7]
        ending = [4,7]

        current_game.assess_endofround_enpassant(starting, ending, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(7)
      end

      it "returns the Black Pawn's @can_en_passant_column to be nil when White Pawn only moves 1 space and En Passant not possible" do
        
        current_game.board[5][7] = WhitePawn.new('white')
        current_game.board[4][6] = BlackPawn.new('black')
        black_pawn = current_game.board[4][6]
        starting = [5,7]
        ending = [4,7]

        current_game.assess_endofround_enpassant(starting, ending, current_game.board)


        expect(black_pawn.can_en_passant_column).to eq(nil)
      end
    end
  end

  describe '#verify_checkmate' do

    subject(:current_game) {described_class.new}

    context 'When checking if the attacking Black player can perform Checkmate on a White King piece' do

      it "returns true when Black has a Rook [0,2] adjescent to a White King [0,0]" do
        
        current_game.populate_gameboard
        current_game.board[6][2] = Knight.new('black')
        current_game.move_gamepiece([6,4],[5,4],current_game.board)
        current_game.show_display


        is_checkmate_occurring = current_game.verify_checkmate('white', current_game.board)
        
        expect(is_checkmate_occurring).to be false
      end
    end
  end
end