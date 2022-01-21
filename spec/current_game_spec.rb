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

        is_movement_legal = current_game.verify_movement(movement, color, current_game.board)
        
        expect(is_movement_legal).to be false
      end

      it "returns true with movement [6,0,4,0] moving White Pawn from start up two spaces" do
        
        current_game.board[6][0] = WhitePawn.new('white')
        movement = [6,0,4,0]
        color = 'white'

        is_movement_legal = current_game.verify_movement(movement, color, current_game.board)
        
        expect(is_movement_legal).to be true
      end

      it "Returns true that CurrentGame successfully verified the En Passant attacking movement" do
        
        current_game.populate_gameboard
        current_game.play_turn([6,0,4,0])
        current_game.play_turn([1,7,3,7])
        current_game.play_turn([4,0,3,0])
        current_game.play_turn([1,1,3,1])
        enpassant_movement = [3,0,2,1]

        is_enpassant_verified = current_game.verify_movement(enpassant_movement, 'white', current_game.board)
        
        expect(is_enpassant_verified).to be true
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

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)
        
        expect(is_ending_coordinate_legal).to be false
      end

      it "returns true moving Black King from [0][0] to attack White Rook at [1][0] to escape from a check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('white')
        start_coord = [0,0]
        end_coord = [1,0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)
        
        expect(is_ending_coordinate_legal).to be true
      end

      it "will return false when moving a Black Rook from [1][0] to [1][1] placing King in Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,0]
        end_coord = [1,1]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)
        
        expect(is_ending_coordinate_legal).to be false
      end
      
      it "will return false when moving a Black Rook from [1][0] to attack White Rook at [1][4] placing King in Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[1][4] = Rook.new('white')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,0]
        end_coord = [1,4]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)
        
        expect(is_ending_coordinate_legal).to be false
      end
            
      it "will return true when moving a Black Rook from [1][1] to [1][0] to move King out of Check" do
        
        current_game.board[0][0] = King.new('black')
        current_game.board[1][1] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1,1]
        end_coord = [1,0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)
        
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

  describe '#promote_eligible_pawns' do

    subject(:current_game) {described_class.new}

    context 'When checking if any Pawns on the board can be promoted to Queens' do

      it "returns true when White moves a pawn to row 0, promoting it to a Queen" do
        
        current_game.board[1][0] = WhitePawn.new('white')
        current_game.move_gamepiece([1,0], [0,0], current_game.board)

        current_game.promote_eligible_pawns(current_game.board)
        
        expect(current_game.board[0][0]).to be_a Queen
      end

      it "returns true when Black moves a pawn to row 7, promoting it to a Queen]" do
        
        current_game.board[6][7] = BlackPawn.new('black')
        current_game.move_gamepiece([6,7], [7,7], current_game.board)

        current_game.promote_eligible_pawns(current_game.board)
        
        expect(current_game.board[7][7]).to be_a Queen
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

  describe '#play_turn' do

    subject(:current_game) {described_class.new}

    context 'When testing if consecutive turns yield proper functionality' do

      it "Returns successfully performs enpassant attack and resets attacking pawn's @can_enpassant_column to nil" do
        
        current_game.populate_gameboard
        current_game.play_turn([6,0,4,0])
        current_game.play_turn([1,7,3,7])
        current_game.play_turn([4,0,3,0])
        current_game.play_turn([1,1,3,1])
        enpassant_movement = [3,0,2,1]
        attacking_white_pawn = current_game.get_piece([3,0])

        current_game.play_turn(enpassant_movement)

        expect(attacking_white_pawn.can_en_passant_column).to eq(nil)
      end
    end
  end
end