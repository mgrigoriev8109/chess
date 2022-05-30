# spec/castling_spec.rb
require 'current_game'

describe CurrentGame do
  describe '#player_performing_castling' do
    subject(:current_game) { described_class.new }
    context 'when a player asks the CurrentGame if a castling from starting to ending location possible' do
      it 'returns true when the piece is a King attempting to move left or right two spaces from start' do
        current_game.board[0][4] = King.new('black')
        king_start = [0, 4]
        king_castling_end = [0, 2]

        can_king_move_castling = current_game.player_performing_castling(king_start, king_castling_end)

        expect(can_king_move_castling).to be true
      end

      it 'returns true when the piece is a King attempting to move left or right two spaces from start' do
        current_game.board[7][4] = King.new('white')
        king_start = [7, 4]
        king_castling_end = [7, 6]

        can_king_move_castling = current_game.player_performing_castling(king_start, king_castling_end)

        expect(can_king_move_castling).to be true
      end

      it 'returns false when the piece is a King attempting to move right one space from start' do
        current_game.board[7][4] = King.new('white')
        king_start = [7, 4]
        king_castling_end = [7, 5]

        can_king_move_castling = current_game.player_performing_castling(king_start, king_castling_end)

        expect(can_king_move_castling).to be false
      end
    end
  end

  describe '#king_also_lands_on' do
    subject(:current_game) { described_class.new }
    context 'when looking for the two coordinates a king passes through while castling in a given direction' do
      it 'returns [[0,3],[0,2]] going left from [0,4]' do
        current_game.board[0][4] = King.new('black')
        king_location = [0, 4]
        castling_direction = 'left'

        movements = current_game.king_also_lands_on(king_location, castling_direction)

        expect(movements).to eq([[0, 3], [0, 2]])
      end

      it 'returns [[7,5],[7,6]] going right from [7,4]' do
        current_game.board[7][4] = King.new('white')
        king_location = [7, 4]
        castling_direction = 'right'

        movements = current_game.king_also_lands_on(king_location, castling_direction)

        expect(movements).to eq([[7, 5], [7, 6]])
      end
    end
  end

  describe '#is_king_landing_in_check' do
    subject(:current_game) { described_class.new }
    context 'when looking to see if a king lands in check on any location on the way to castling end destination' do
      it 'returns false because no other white pieces are on the board' do
        current_game.board[0][4] = King.new('black')
        current_game.board[1][3] = Rook.new('black')
        king_location = [0, 4]
        castling_direction = 'left'

        lands_in_check = current_game.is_king_landing_in_check(king_location, current_game.board, castling_direction)

        expect(lands_in_check).to be false
      end

      it 'returns true because a Rook puts king in check when trying to castle left' do
        current_game.board[0][4] = King.new('black')
        current_game.board[1][2] = Rook.new('white')
        king_location = [0, 4]
        castling_direction = 'left'

        lands_in_check = current_game.is_king_landing_in_check(king_location, current_game.board, castling_direction)

        expect(lands_in_check).to be true
      end

      it 'returns false because a Rook is on the right while king trying to castle left' do
        current_game.board[0][4] = King.new('black')
        current_game.board[1][5] = Rook.new('white')
        king_location = [0, 4]
        castling_direction = 'left'

        lands_in_check = current_game.is_king_landing_in_check(king_location, current_game.board, castling_direction)

        expect(lands_in_check).to be false
      end
    end
  end

  describe '#pieces_between_king_rook' do
    subject(:current_game) { described_class.new }
    context 'when looking to see if a there are any pieces between the King and Rook attempting to castle' do
      it 'returns false because no other pieces inbetween the Black King and Rook' do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')
        current_game.board[0][5] = Rook.new('black')
        king_location = [0, 4]
        rook_location = [0, 0]

        are_pieces_between = current_game.pieces_between_king_rook(king_location, rook_location, current_game.board)

        expect(are_pieces_between).to be false
      end

      it 'returns true because there is another Rook inbetween the Black King and Rook' do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')
        current_game.board[0][2] = Rook.new('black')
        king_location = [0, 4]
        rook_location = [0, 0]

        are_pieces_between = current_game.pieces_between_king_rook(king_location, rook_location, current_game.board)

        expect(are_pieces_between).to be true
      end

      it 'returns true because there is another Rook inbetween the White King and Rook' do
        current_game.board[7][4] = King.new('white')
        current_game.board[7][7] = Rook.new('white')
        current_game.board[7][6] = Rook.new('white')
        king_location = [7, 4]
        rook_location = [7, 7]

        are_pieces_between = current_game.pieces_between_king_rook(king_location, rook_location, current_game.board)

        expect(are_pieces_between).to be true
      end

      it 'returns false because there are no pieces between the White King and Rook' do
        current_game.board[7][4] = King.new('white')
        current_game.board[7][7] = Rook.new('white')
        king_location = [7, 4]
        rook_location = [7, 7]

        are_pieces_between = current_game.pieces_between_king_rook(king_location, rook_location, current_game.board)

        expect(are_pieces_between).to be false
      end
    end
  end

  describe '#verify_castling_conditions' do
    subject(:current_game) { described_class.new }
    context 'when verifying the four conditions necessary to be able to castle' do
      it "returns true because Black King and Rook haven't moved, no pieces inbetween to the left, and king doesn't land in check" do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')

        are_condtions_verified = current_game.verify_castling_conditions('black', current_game.board, 'left')

        expect(are_condtions_verified).to be true
      end

      it 'returns false because Black King has moved' do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')
        king_start = [0, 4]
        king_end = [0, 3]

        current_game.move_gamepiece(king_start, king_end, current_game.board)
        current_game.have_rooks_or_kings_moved(king_end, current_game.board)
        are_condtions_verified = current_game.verify_castling_conditions('black', current_game.board, 'left')

        expect(are_condtions_verified).to be false
      end

      it 'returns false because Black Rook has moved' do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')
        rook_start = [0, 0]
        rook_end = [0, 3]

        current_game.move_gamepiece(rook_start, rook_end, current_game.board)
        current_game.have_rooks_or_kings_moved(rook_end, current_game.board)
        are_condtions_verified = current_game.verify_castling_conditions('black', current_game.board, 'left')

        expect(are_condtions_verified).to be false
      end

      it 'returns false because Black Rook has moved and is back to its original position' do
        current_game.board[0][4] = King.new('black')
        current_game.board[0][0] = Rook.new('black')
        rook_start = [0, 0]
        rook_end = [0, 3]

        current_game.move_gamepiece(rook_start, rook_end, current_game.board)
        current_game.have_rooks_or_kings_moved(rook_end, current_game.board)
        current_game.move_gamepiece([0, 3], [0, 0], current_game.board)
        are_condtions_verified = current_game.verify_castling_conditions('black', current_game.board, 'left')

        expect(are_condtions_verified).to be false
      end

      it 'returns false because there is a piece inbetween the White King and Rook' do
        current_game.board[7][4] = King.new('white')
        current_game.board[7][7] = Rook.new('white')
        current_game.board[7][6] = Rook.new('white')

        are_condtions_verified = current_game.verify_castling_conditions('white', current_game.board, 'right')

        expect(are_condtions_verified).to be false
      end

      it 'returns false because the White King can land in a check while moving into Castling' do
        current_game.board[7][4] = King.new('white')
        current_game.board[7][7] = Rook.new('white')
        current_game.board[6][6] = Rook.new('black')

        are_condtions_verified = current_game.verify_castling_conditions('white', current_game.board, 'right')

        expect(are_condtions_verified).to be false
      end
    end
  end

  describe '#can_next_player_castle' do
    subject(:current_game) { described_class.new }
    context 'when looking whether or not the next player can castle during their turn' do
      it 'returns false because the next player is White, and pieces are in the way both directions' do
        current_game.populate_gameboard
        current_player_color = 'black'
        white_king = current_game.board[7][4]

        current_game.can_next_player_castle(current_player_color, current_game.board)

        expect(white_king.castling_coordinates).to be false
      end

      it 'returns true because the next player is White, and has room to castle to the right' do
        current_game.populate_gameboard
        current_game.board[7][5] = ' '
        current_game.board[7][6] = ' '
        current_player_color = 'black'
        white_king = current_game.board[7][4]

        current_game.can_next_player_castle(current_player_color, current_game.board)

        expect(white_king.castling_coordinates).to eq([7, 6])
      end

      it 'returns true because the next player is Black, and has room to castle to the right' do
        current_game.populate_gameboard
        current_game.board[0][3] = ' '
        current_game.board[0][2] = ' '
        current_game.board[0][1] = ' '
        current_player_color = 'white'
        black_king = current_game.board[0][4]

        current_game.can_next_player_castle(current_player_color, current_game.board)

        expect(black_king.castling_coordinates).to eq([0, 2])
      end

      it 'returns false because the next player is White, and has room to castle to the right but moved through check' do
        current_game.populate_gameboard
        current_game.board[7][5] = ' '
        current_game.board[7][6] = ' '
        current_game.board[6][6] = Rook.new('black')
        current_player_color = 'black'
        white_king = current_game.board[7][4]

        current_game.can_next_player_castle(current_player_color, current_game.board)

        expect(white_king.castling_coordinates).to be false
      end
    end
  end

  describe '#move_castling_rook' do
    subject(:current_game) { described_class.new }
    context 'after successfully moving a king using castling' do
      it "returns a Rook in the Rook's desired end location [0,3], matching up with the Black King's castling direction of left" do
        current_game.populate_gameboard
        current_player_color = 'black'
        king_start = [0, 4]
        king_end = [0, 2]
        rook_after_castling = [0, 3]

        current_game.move_castling_rook(current_player_color, king_start, king_end, current_game.board)

        expect(current_game.get_piece(rook_after_castling)).to be_a(Rook)
      end

      it "returns a Rook in the Rook's desired end location [7,5], matching up with the White King's castling direction of right" do
        current_game.populate_gameboard
        current_player_color = 'white'
        king_start = [7, 4]
        king_end = [7, 6]
        rook_after_castling = [7, 5]

        current_game.move_castling_rook(current_player_color, king_start, king_end, current_game.board)

        expect(current_game.get_piece(rook_after_castling)).to be_a(Rook)
      end
    end
  end
end
