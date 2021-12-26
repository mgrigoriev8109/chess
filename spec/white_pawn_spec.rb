#spec/white_pawn_spec.rb
require 'white_pawn'
require 'current_game'

describe WhitePawn do

  describe '#movements_right' do
    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:white_pawn) {described_class.new('white')}

    context 'A white pawn looking for possible movements' do

      it "returns an array of [[5,0],[4,0]] from its starting location [6,0]" do

        board[6][0] = WhitePawn.new('white')

        possible_movements = white_pawn.movements(board, [6,0])
        
        expect(possible_movements).to eq([[4, 0], [5, 0]])

      end

      it "returns an array of [[4,0]] from [5,0]" do

        board[5][0] = WhitePawn.new('white')

        possible_movements = white_pawn.movements(board, [5,0])
        
        expect(possible_movements).to eq([[4, 0]])

      end

      it "returns an array of [] from its starting location [6,0] if Piece in front of Pawn" do

        board[6][0] = WhitePawn.new('white')
        board[5][0] = WhitePawn.new('white')

        possible_movements = white_pawn.movements(board, [6,0])
        
        expect(possible_movements).to eq([])

      end
    end
  end
end
