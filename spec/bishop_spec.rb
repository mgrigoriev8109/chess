#spec/bishop_spec.rb
require 'bishop'
require 'current_game'
require 'player'

describe Bishop do

  describe '#movements_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'When a bishop is looking for possible up right diagonal movements' do

      it "from [2,0] returns an array of [[1,1]] when stopping at a Black Bishop at [0,2]" do

        board[2][0] = Bishop.new('white')
        board[0][2] = Bishop.new('black')

        possible_movements = bishop.movements_up_right(board, [2,0])
        
        expect(possible_movements).to eq([[1,1]])

      end

      it "from [1,1] returns an array of [[0,2]] when stopping at the board edge" do

        board[1][1] = Bishop.new('white')

        possible_movements = bishop.movements_up_right(board, [1,1])
        
        expect(possible_movements).to eq([[0,2]])
      end

      it "from [5,2] returns an array of [[0,2]] when stopping at the board edge" do

        board[5][2] = Bishop.new('white')
        board[1][5] = Bishop.new('white')

        possible_movements = bishop.movements_up_right(board, [5,2])
        
        expect(possible_movements).to eq([[0, 7], [1, 6], [2, 5], [3, 4], [4, 3]])
      end

      it "from [5,2] returns an array of [[0,2]] when stopping at a White Bishop at [1,6]" do

        board[5][2] = Bishop.new('white')
        board[1][6] = Bishop.new('white')

        possible_movements = bishop.movements_up_right(board, [5,2])
        
        expect(possible_movements).to eq([[2, 5], [3, 4], [4, 3]])
      end

    end
  end
end