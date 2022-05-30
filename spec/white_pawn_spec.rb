# spec/white_pawn_spec.rb
require 'pieces/white_pawn'
require 'pieces/black_pawn'
require 'pieces/rook'
require 'current_game'

describe WhitePawn do
  describe '#all_possible_movements' do
    let(:board) { Array.new(8) { Array.new(8, ' ') } }
    subject(:white_pawn) { described_class.new('white') }

    context 'A white pawn looking for possible movements' do
      it 'returns an array of [[5,0],[4,0]] from its starting location [6,0]' do
        board[6][0] = WhitePawn.new('white')

        possible_movements = white_pawn.all_possible_movements(board, [6, 0])

        expect(possible_movements).to eq([[4, 0], [5, 0]])
      end

      it 'returns an array of [[4,0]] from [5,0]' do
        board[5][0] = WhitePawn.new('white')

        possible_movements = white_pawn.all_possible_movements(board, [5, 0])

        expect(possible_movements).to eq([[4, 0]])
      end

      it 'returns an array of [] from its starting location [6,0] if Piece in front of Pawn' do
        board[6][0] = WhitePawn.new('white')
        board[5][0] = WhitePawn.new('white')

        possible_movements = white_pawn.all_possible_movements(board, [6, 0])

        expect(possible_movements).to eq([])
      end
    end
  end

  describe '#all_possible_attacks' do
    let(:board) { Array.new(8) { Array.new(8, ' ') } }
    subject(:white_pawn) { described_class.new('white') }

    context 'A white pawn looking for possible attacks' do
      it 'returns an array of [[5,0],[5,2]] from its starting location [6,1] when seeing two Black Rooks' do
        board[6][1] = WhitePawn.new('white')
        board[5][2] = Rook.new('black')
        board[5][0] = Rook.new('black')

        possible_attacks = white_pawn.all_possible_attacks(board, [6, 1])

        expect(possible_attacks).to eq([[5, 0], [5, 2]])
      end

      it 'returns an array of [[5,2]] from its starting location [6,1] when seeing only one Black Rook' do
        board[6][1] = WhitePawn.new('white')
        board[5][2] = Rook.new('black')
        board[5][0] = Rook.new('white')

        possible_attacks = white_pawn.all_possible_attacks(board, [6, 1])

        expect(possible_attacks).to eq([[5, 2]])
      end

      it 'returns possible [[2,0],[2,2]] regular attack and En Passant possible attack from location [3,1] after BlackPawn moved from [[1,0]] ' do
        board[3][1] = WhitePawn.new('white')
        board[3][0] = BlackPawn.new('black')
        board[3][2] = BlackPawn.new('black')
        board[2][2] = BlackPawn.new('black')
        white_pawn.can_en_passant_column = 0

        possible_attacks = white_pawn.all_possible_attacks(board, [3, 1])

        expect(possible_attacks).to eq([[2, 0], [2, 2]])
      end
    end
  end
end
