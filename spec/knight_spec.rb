#spec/knight_spec.rb
require 'knight'
require 'current_game'
require 'player'

describe Knight do

  describe '#movements_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:knight) {described_class.new('white')}

    context 'When a knight is looking for possible up right diagonal movements' do

      it "from [2,0] returns an array of [[1,1]] when stopping at a Black knight at [0,2]" do

        board[2][0] = Knight.new('white')
        board[0][2] = Knight.new('black')

        possible_movements = knight.movements_up_right(board, [2,0])
        
        expect(possible_movements).to eq([[1,1]])

      end
    end
  end
end
