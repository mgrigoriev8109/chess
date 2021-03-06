# frozen_string_literal: true

# spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'pieces/rook'
require 'pieces/king'
require 'pieces/bishop'

describe CurrentGame do
  describe '#create_starting_rooks' do
    subject(:current_game) { described_class.new }
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do
      it 'returns true when an instance of Rook exists on that coordinate' do
        current_game.create_starting_rooks
        expect(current_game.board[0][0]).to be_a Rook
      end

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_a Rook
      end
    end
  end

  describe '#verify_movement' do
    subject(:current_game) { described_class.new }

    context 'When verifying that a piece of a color can make a certain movement' do
      it 'returns false with movement [1,0,1,1] moving Black Rook from [1][0] to [1][1] placing Black King in Check' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        movement = [1, 0, 1, 1]
        color = 'black'

        is_movement_legal = current_game.verify_movement(movement, color, current_game.board)

        expect(is_movement_legal).to be false
      end

      it 'returns true with movement [6,0,4,0] moving White Pawn from start up two spaces' do
        current_game.board[6][0] = WhitePawn.new('white')
        movement = [6, 0, 4, 0]
        color = 'white'

        is_movement_legal = current_game.verify_movement(movement, color, current_game.board)

        expect(is_movement_legal).to be true
      end

      it 'Returns true that CurrentGame successfully verified the En Passant attacking movement' do
        current_game.populate_gameboard
        current_game.play_turn([6, 0, 4, 0])
        current_game.play_turn([1, 7, 3, 7])
        current_game.play_turn([4, 0, 3, 0])
        current_game.play_turn([1, 1, 3, 1])
        enpassant_movement = [3, 0, 2, 1]

        is_enpassant_verified = current_game.verify_movement(enpassant_movement, 'white', current_game.board)

        expect(is_enpassant_verified).to be true
      end

      it 'Returns true that CurrentGame successfully verified the Castling movement' do
        current_game.populate_gameboard
        current_game.board[7][1] = ' '
        current_game.board[7][2] = ' '
        current_game.board[7][3] = ' '
        current_game.play_turn([1, 4, 3, 4])
        castling_movement = [7, 4, 7, 2]

        is_castling_verified = current_game.verify_movement(castling_movement, 'white', current_game.board)

        expect(is_castling_verified).to be true
      end
    end
  end

  describe '#verify_start' do
    subject(:current_game) { described_class.new }

    context 'When verifying a piece has a certain color at certain starting coordinates' do
      it 'returns false if the no pieces have been created on the board' do
        current_game.board[0][0] = ' '
        starting_coordinates = [0, 0]
        color = 'white'

        is_start_verified = current_game.verify_start(starting_coordinates, color)

        expect(is_start_verified).to be false
      end

      it 'returns false if the White Rook at [0,0] was created, and then deleted' do
        current_game.board[0][0] = Rook.new('white')
        current_game.board[0][0] = ' '
        starting_coordinates = [0, 0]
        color = 'white'

        is_start_verified = current_game.verify_start(starting_coordinates, color)

        expect(is_start_verified).to be false
      end

      it 'returns true if looking for black piece at [0,0] and a Black Rook exists there' do
        current_game.board[0][0] = Rook.new('black')
        starting_coordinates = [0, 0]
        color = 'black'

        is_start_verified = current_game.verify_start(starting_coordinates, color)

        expect(is_start_verified).to be true
      end

      it 'returns false if looking for a black piece at [0,0] and a White Rook exists there' do
        current_game.board[0][0] = Rook.new('white')
        starting_coordinates = [0, 0]
        color = 'black'

        is_start_verified = current_game.verify_start(starting_coordinates, color)

        expect(is_start_verified).to be false
      end
    end
  end

  describe '#verify_end' do
    subject(:current_game) { described_class.new }

    context 'When player verifying if move legal or will cause him/her to go into check' do
      it 'returns false moving Black King from [0][0] to [1][0] where White Rook can attack' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('white')
        current_game.board[1][1] = Rook.new('white')
        start_coord = [0, 0]
        end_coord = [1, 0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)

        expect(is_ending_coordinate_legal).to be false
      end

      it 'returns true moving Black King from [0][0] to attack White Rook at [1][0] to escape from a check' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('white')
        start_coord = [0, 0]
        end_coord = [1, 0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)

        expect(is_ending_coordinate_legal).to be true
      end

      it 'will return false when moving a Black Rook from [1][0] to [1][1] placing King in Check' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1, 0]
        end_coord = [1, 1]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)

        expect(is_ending_coordinate_legal).to be false
      end

      it 'will return false when moving a Black Rook from [1][0] to attack White Rook at [1][4] placing King in Check' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][0] = Rook.new('black')
        current_game.board[1][4] = Rook.new('white')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1, 0]
        end_coord = [1, 4]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)

        expect(is_ending_coordinate_legal).to be false
      end

      it 'will return true when moving a Black Rook from [1][1] to [1][0] to move King out of Check' do
        current_game.board[0][0] = King.new('black')
        current_game.board[1][1] = Rook.new('black')
        current_game.board[2][0] = Rook.new('white')
        start_coord = [1, 1]
        end_coord = [1, 0]

        is_ending_coordinate_legal = current_game.verify_end(start_coord, end_coord, current_game.board)

        expect(is_ending_coordinate_legal).to be true
      end
    end
  end

  describe '#get_piece' do
    subject(:current_game) { described_class.new }

    context 'When trying to retrieve the gamepiece from a given coordinate' do
      it 'returns from a Black King located at [0,0]' do
        current_game.board[0][0] = King.new('black')

        piece = current_game.get_piece([0, 0])

        expect(piece).to be_a(King)
      end
    end
  end

  describe '#move_gamepiece' do
    let(:player) do
      instance_double(Player, color: 'white', name: 'player', starting_location: [0, 0], ending_location: [1, 0])
    end
    subject(:current_game) { described_class.new }

    context 'When moving a Black Rook from A8, aka [0,0] aka [0][0]' do
      it 'the board will return a Black Rook at A7, aka [1.0], aka [1][0]' do
        current_game.board[0][0] = Rook.new('black')
        starting_location = [0, 0]
        ending_location = [1, 0]

        current_game.move_gamepiece(starting_location, ending_location, current_game.board)
        ending_coordinates = current_game.board[1][0]

        expect(ending_coordinates).to be_a Rook
      end

      it "and also return empty space ' ' at [0][0]" do
        current_game.board[0][0] = Rook.new('black')
        starting_location = [0, 0]
        ending_location = [1, 0]

        current_game.move_gamepiece(starting_location, ending_location, current_game.board)
        starting_coordinates = current_game.board[0][0]

        expect(starting_coordinates).to eq(' ')
      end
    end
  end

  describe '#promote_eligible_pawns' do
    subject(:current_game) { described_class.new }

    context 'When checking if any Pawns on the board can be promoted to Queens' do
      it 'returns true when White moves a pawn to row 0, promoting it to a Queen' do
        current_game.board[1][0] = WhitePawn.new('white')
        current_game.move_gamepiece([1, 0], [0, 0], current_game.board)

        current_game.promote_eligible_pawns(current_game.board)

        expect(current_game.board[0][0]).to be_a Queen
      end

      it 'returns true when Black moves a pawn to row 7, promoting it to a Queen]' do
        current_game.board[6][7] = BlackPawn.new('black')
        current_game.move_gamepiece([6, 7], [7, 7], current_game.board)

        current_game.promote_eligible_pawns(current_game.board)

        expect(current_game.board[7][7]).to be_a Queen
      end
    end
  end

  describe '#get_all_attacks_against' do
    subject(:current_game) { described_class.new }

    context 'When getting array of all the possible attack coordinates against a player' do
      it 'returns [[0,0], [2,2]] because the white rook at [0,2] can attack the two black pieces' do
        current_game.board[0][0] = King.new('black')
        current_game.board[0][2] = Rook.new('white')
        current_game.board[2][2] = Bishop.new('black')
        current_game.board[3][3] = Bishop.new('black')
        current_game.board[0][5] = King.new('white')

        all_attacks_against_black = current_game.get_all_attacks_against('black', current_game.board)

        expect(all_attacks_against_black).to eq([[0, 0], [2, 2]])
      end
    end
  end

  describe '#get_king_location' do
    subject(:current_game) { described_class.new }

    context 'When looking for the black player king' do
      it 'returns the location at [0,0]' do
        current_game.board[0][0] = King.new('black')
        current_game.board[0][2] = Rook.new('black')
        current_game.board[0][3] = King.new('white')

        black_king_location = current_game.get_king_location('black', current_game.board)

        expect(black_king_location).to eq([0, 0])
      end
    end
  end

  describe '#play_turn' do
    subject(:current_game) { described_class.new }

    context 'When testing if consecutive turns yield proper functionality' do
      it "Returns successfully performs enpassant attack and resets attacking pawn's @can_enpassant_column to nil" do
        current_game.populate_gameboard
        current_game.play_turn([6, 0, 4, 0])
        current_game.play_turn([1, 7, 3, 7])
        current_game.play_turn([4, 0, 3, 0])
        current_game.play_turn([1, 1, 3, 1])
        enpassant_movement = [3, 0, 2, 1]
        attacking_white_pawn = current_game.get_piece([3, 0])

        current_game.play_turn(enpassant_movement)

        expect(attacking_white_pawn.can_en_passant_column).to eq(nil)
      end

      it 'Returns true that CurrentGame successfully verified the Castling movement' do
        current_game.populate_gameboard
        current_game.board[7][1] = ' '
        current_game.board[7][2] = ' '
        current_game.board[7][3] = ' '
        current_game.play_turn([1, 4, 3, 4])
        castling_movement = [7, 4, 7, 2]

        current_game.play_turn(castling_movement)
        white_king = current_game.get_piece([7, 2])

        expect(white_king).to be_a(King)
      end

      it "Returns nil as a white pawn's @can_en_passant_column after nothing happens to trigger it" do
        current_game.populate_gameboard
        white_pawn = current_game.get_piece([6, 4])

        current_game.play_turn([1, 1, 3, 3])

        expect(white_pawn.can_en_passant_column).to eq(nil)
      end

      it 'Returns a movement length of 4 showing that #determine_computer_movement escapes check properly' do
        current_game.populate_gameboard
        current_game.play_turn([6, 5, 4, 5])
        current_game.play_turn([1, 4, 3, 4])
        current_game.play_turn([0, 3, 4, 7])

        movement_escaping_check = current_game.determine_computer_movement('white', current_game.board)
        current_game.play_turn(movement_escaping_check)

        expect(movement_escaping_check.length).to eq(4)
      end

      it 'Recreates a bug where Black Queen can reach White King through an impossible attack' do
        current_game.board[4][2] = WhitePawn.new('white')
        current_game.board[4][1] = Knight.new('black')
        current_game.board[3][4] = Queen.new('black')
        current_game.board[5][3] = King.new('white')
        current_game.show_display

        movement_escaping_check = current_game.determine_computer_movement('white', current_game.board)

        expect(movement_escaping_check.length).to eq(4)
      end

      it 'Integration test to check that White King can castle right' do
        current_game.populate_gameboard
        current_game.board[7][5] = ' '
        current_game.board[7][6] = ' '
        black_movement = [1, 0, 3, 0]
        white_castling_movement = [7, 4, 7, 6]

        current_game.play_turn(black_movement)
        castling_movement_verified = current_game.verify_movement(white_castling_movement, 'white', current_game.board)
        current_game.play_turn(white_castling_movement)

        expect(castling_movement_verified).to be true
      end

      it 'Integration test to check that White King can castle left' do
        current_game.populate_gameboard
        current_game.board[7][3] = ' '
        current_game.board[7][2] = ' '
        current_game.board[7][1] = ' '
        black_movement = [1, 0, 3, 0]
        white_castling_movement = [7, 4, 7, 2]

        current_game.play_turn(black_movement)
        castling_movement_verified = current_game.verify_movement(white_castling_movement, 'white', current_game.board)
        current_game.play_turn(white_castling_movement)

        expect(castling_movement_verified).to be true
      end

      it 'Recreate bug of Pawn Promotion turning the wrong piece into a Queen' do
        current_game.board[6][5] = BlackPawn.new('black')
        current_game.board[5][7] = King.new('black')
        current_game.board[4][1] = King.new('white')
        black_movement = [6, 5, 7, 5]

        current_game.play_turn(black_movement)
        current_game.show_display

        expect(current_game.board[7][5]).to be_a(Queen)
      end
    end
  end
end
