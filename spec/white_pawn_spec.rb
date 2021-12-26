#spec/white_pawn_spec.rb
require 'white_pawn'
require 'current_game'

describe WhitePawn do

  describe '#movements_right' do
    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:white_pawn) {described_class.new('white')}

    context 'from [0,1]' do

      it "returns an array of [[0,2]] when stopping at [0][3]" do

        board[0][3] = WhitePawn.new('white')

        possible_movements = white_pawn.movements_right(board, [0,1])
        
        expect(possible_movements).to eq([[0,2]])

      end
    end
  end
end
