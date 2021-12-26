#spec/knight_spec.rb
require 'knight'
require 'current_game'

describe Knight do

  describe '#movements_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:knight) {described_class.new('white')}

    context 'When a knight is looking for possible movement up 2 squares right 1 square' do

      it "from [3,3] returns an array of [[1,4]] when [1,4] is empty" do

        board[3][3] = Knight.new('white')

        possible_movement = knight.movements_up_right(board, [3,3])
        
        expect(possible_movement).to eq([[1,4]])
      end
    end
  end
end
