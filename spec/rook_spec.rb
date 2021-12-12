#spec/rook_spec.rb
require 'rook'
require 'current_game'
require 'player'

describe Rook do

  describe '#movements_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [0,1]' do

      it "returns an array of [[0,2]] when stopping at [0][3]" do

      board[0][3] = Rook.new('white')
      board[0][1] = Rook.new('black')

      possible_movements = rook.movements_right(board, [0,1])
      
      expect(possible_movements).to eq([[0,2]])
      end

      it "returns an array of [[0,2][0,3]] when stopping at [0][4]" do

      board[0][4] = Rook.new('white')
      board[0][1] = Rook.new('black')

      possible_movements = rook.movements_right(board, [0,1])
      
      expect(possible_movements).to eq([[0,2],[0,3]])
      end

    end
  end

  describe '#movements_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [0,1]' do
      it "returns an array of [[0,0]] when stopping at the left board edge" do

      board[0][1] = Rook.new('black')

      possible_movements = rook.movements_left(board, [0,1])
      
      expect(possible_movements).to eq([[0,0]])
      end

    end
  end

  describe '#movements_down' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [6,0]' do
      it "returns an array of [[7,0]] when stopping at the lower board edge" do

      board[6][0] = Rook.new('black')

      possible_movements = rook.movements_down(board, [6,0])
      
      expect(possible_movements).to eq([[7,0]])
      end

    end
  end

  describe '#movements_up' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}
    context 'from [1,0]' do
      it "returns an array of [[0,0]] when stopping at the upper board edge" do

      board[1][0] = Rook.new('black')

      possible_movements = rook.movements_up(board, [1,0])
      
      expect(possible_movements).to eq([[0,0]])
      end

    end
  end
end
