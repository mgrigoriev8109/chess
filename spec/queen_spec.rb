#spec/queen_spec.rb
require 'queen'
require 'current_game'

describe Queen do

  describe '#all_possible_attacks' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:queen) {described_class.new('white')}

    context 'A White Queen starting at [1,1]' do

      it "returns an array of [[1,2],[3,1],[0,1]], but NOT [1,0] when three black Rooks and one white Rook around" do
        
        board[1][1] = Queen.new('white')
        board[1][2] = Rook.new('black')
        board[3][1] = Rook.new('black')
        board[0][1] = Rook.new('black')
        board[2][0] = Bishop.new('black')
        board[0][2] = Bishop.new('black')

        possible_attacks = queen.all_possible_attacks(board, [1,1])

        expect(possible_attacks).to eq([[2, 0], [0, 2], [1, 2], [0, 1], [3, 1]])
      end
    end
  end
end