#spec/king_spec.rb
require 'king'
require 'current_game'
require 'player'

describe King do

  describe '#all_possible_movements' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A king searching for possible movements' do

      it "starting at [1,1] returns an array of[[1, 2], [1, 0], [0, 1], [2, 1], [2, 0], [2, 2], [0, 0], [0, 2]]" do
        
        board[1][1] = King.new('white')

        possible_movements = king.all_possible_movements(board, [1,1])

        expect(possible_movements).to eq([[1, 2], [1, 0], [0, 1], [2, 1], [2, 0], [2, 2], [0, 0], [0, 2]])
      end

    end
  end

end
