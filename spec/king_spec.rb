#spec/king_spec.rb
require 'king'
require 'current_game'
require 'player'

describe King do

  describe '#all_possible_movements' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A king searching for possible movements' do

      it "starting at [0,0] returns an array of [[0,1],[1,0]] when other pieces at [0,3] and [3,0]" do
        
        board[0][0] = King.new('black')
        board[0][3] = King.new('white')
        board[3][0] = King.new('white')

        possible_movements = king.all_possible_movements(board, [0,0])

        expect(possible_movements).to eq([[0,1],[1,0]])
      end

    end
  end

end