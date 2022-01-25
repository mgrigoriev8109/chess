#spec/queen_spec.rb
require 'queen'
require 'knight'
require 'white_pawn'
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

      it "returns an array of [] when Queen can't reach enemy King" do
        
        board[3][4] = Queen.new('black')
        board[6][3] = King.new('white')

        possible_attacks = board[3][4].all_possible_attacks(board, [3,4])

        expect(possible_attacks).to eq([])
      end
    end
  end

  describe '#all_possible_movements' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:queen) {described_class.new('white')}

    context 'A queen starting at [0,0]' do

      it "returns an array of [[0,1],[0,2],[1,0],[2,0]] when other pieces at [0,3] and [3,0]" do
        
        board[0][0] = Queen.new('black')
        board[0][3] = Rook.new('white')
        board[3][0] = Rook.new('white')
        board[2][2] = Bishop.new('white')

        possible_movements = queen.all_possible_movements(board, [0,0])

        expect(possible_movements).to eq([[1, 1], [0, 1], [0, 2], [1, 0], [2, 0]])
      end
    end
  end

  describe '#attacks_up_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:queen) {described_class.new('white')}

    context 'A queen starting at [0,0]' do

      it "returns an array of [] when queen can't attack king" do
        
        board[4][2] = WhitePawn.new('white')
        board[4][1] = Knight.new('black')
        board[3][4] = Queen.new('black')
        board[6][3] = King.new('white')

        possible_attack = queen.attacks_up_left(board, [3,4])

        expect(possible_attack).to eq([])
      end
    end
  end
end