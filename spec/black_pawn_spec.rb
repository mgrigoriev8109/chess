# spec/black_pawn_spec.rb
require 'pieces/black_pawn'
require 'pieces/white_pawn'
require 'pieces/rook'
require 'current_game'

describe BlackPawn do
  describe '#all_possible_movements' do
    let(:board) { Array.new(8) { Array.new(8, ' ') } }
    subject(:black_pawn) { described_class.new('black') }

    context 'A black pawn looking for possible movements' do
      it 'returns an array of [[2,0],[3,0]] from its starting location [1,0]' do
        board[1][0] = BlackPawn.new('black')

        possible_movements = black_pawn.all_possible_movements(board, [1, 0])

        expect(possible_movements).to eq([[2, 0], [3, 0]])
      end

      it 'returns an array of [[3,0]] from [2,0]' do
        board[2][0] = BlackPawn.new('black')

        possible_movements = black_pawn.all_possible_movements(board, [2, 0])

        expect(possible_movements).to eq([[3, 0]])
      end

      it 'returns an array of [] from its starting location [1,0] if Piece in front of Pawn' do
        board[1][0] = BlackPawn.new('black')
        board[2][0] = BlackPawn.new('black')

        possible_movements = black_pawn.all_possible_movements(board, [1, 0])

        expect(possible_movements).to eq([])
      end
    end
  end

  describe '#all_possible_attacks' do
    let(:board) { Array.new(8) { Array.new(8, ' ') } }
    subject(:black_pawn) { described_class.new('black') }

    context 'A black pawn looking for possible attacks' do
      it 'returns an array of [[2,0],[2,2]] from its starting location [1,1] when seeing two White Rooks' do
        board[1][1] = BlackPawn.new('black')
        board[2][2] = Rook.new('white')
        board[2][0] = Rook.new('white')

        possible_attacks = black_pawn.all_possible_attacks(board, [1, 1])

        expect(possible_attacks).to eq([[2, 0], [2, 2]])
      end

      it 'returns an array of [[2,0]] from its starting location [1,1] when seeing only one White Rook' do
        board[1][1] = BlackPawn.new('black')
        board[2][2] = Rook.new('black')
        board[2][0] = Rook.new('white')

        possible_attacks = black_pawn.all_possible_attacks(board, [1, 1])

        expect(possible_attacks).to eq([[2, 0]])
      end

      it 'returns possible [[2,0],[2,2]] regular attack and En Passant possible attack from location [3,1] after BlackPawn moved from [[1,0]] ' do
        board[4][1] = BlackPawn.new('black')
        board[4][2] = WhitePawn.new('white')
        board[4][2] = WhitePawn.new('white')
        board[5][0] = WhitePawn.new('white')
        black_pawn.can_en_passant_column = 2

        possible_attacks = black_pawn.all_possible_attacks(board, [4, 1])

        expect(possible_attacks).to eq([[5, 0], [5, 2]])
      end
    end
  end
end
