#spec/rook_spec.rb
require 'rook'
require 'current_game'
require 'player'

describe Rook do

  describe '#row_movements_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [0,1]' do

      it "returns an array of [[0,2]] when stopping at [0][3]" do

      board[0][3] = Rook.new('white')
      board[0][1] = Rook.new('black')

      rook_row_movements = rook.row_movements_right(board, [0,1])
      
      expect(rook_row_movements).to eq([[0,2]])
      end

      it "returns an array of [[0,2][0,3]] when stopping at [0][4]" do

      board[0][4] = Rook.new('white')
      board[0][1] = Rook.new('black')

      rook_row_movements = rook.row_movements_right(board, [0,1])
      
      expect(rook_row_movements).to eq([[0,2],[0,3]])
      end

    end
  end

  describe '#row_movements_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [0,1]' do
      it "returns an array of [[0,0]] when stopping at the left board edge" do

      board[0][4] = Rook.new('white')
      board[0][1] = Rook.new('black')

      rook_row_movements = rook.row_movements_left(board, [0,1])
      
      expect(rook_row_movements).to eq([[0,0]])
      end

    end
  end
end
