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

  describe '#all_possible_movements' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}

    context 'A rook starting at [0,0]' do

      it "returns an array of [[0,1],[0,2],[1,0],[2,0]] when other pieces at [0,3] and [3,0]" do
        
        board[0][0] = Rook.new('black')
        board[0][3] = Rook.new('white')
        board[3][0] = Rook.new('white')

        possible_movements = rook.all_possible_movements(board, [0,0])

        expect(possible_movements).to eq([[0,1],[0,2],[1,0],[2,0]])
      end
    end
  end

  describe '#attacks_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}

    context 'A White Rook looking for pieces to attack to the right' do

      it "returns an array of [0,2] when attacking from [0][0] and seeing a Black Rook at [0][2]" do

        board[0][0] = Rook.new('white')
        board[0][2] = Rook.new('black')

        possible_attacks = rook.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([[0,2]])

      end

      it "returns an array of [0,2] when attacking from [0][0] and seeing a Black Rook at [0][2] and [0][3]" do

        board[0][0] = Rook.new('white')
        board[0][2] = Rook.new('black')
        board[0][3] = Rook.new('black')

        possible_attacks = rook.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([[0,2]])

      end

      it "returns an array of [] when attacking from [0][0] and seeing no black pieces to the right" do

        board[0][0] = Rook.new('white')
        board[0][2] = Rook.new('white')

        possible_attacks = rook.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][0] and seeing no black pieces to the right" do

        board[0][0] = Rook.new('white')
        board[0][2] = Rook.new('white')
        board[0][3] = Rook.new('black')

        possible_attacks = rook.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#attacks_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}

    context 'A White Rook looking for pieces to attack to the left' do

      it "returns an array of [0,2] when attacking from [0][3] and seeing a Black Rook at [0][2]" do

        board[0][3] = Rook.new('white')
        board[0][2] = Rook.new('black')
        board[0][4] = Rook.new('black')

        possible_attacks = rook.attacks_left(board, [0,3])
        
        expect(possible_attacks).to eq([[0,2]])

      end

      it "returns an array of [0,2] when attacking from [0][3] and seeing a Black Rook at [0][2] and [0][1]" do

        board[0][3] = Rook.new('white')
        board[0][2] = Rook.new('black')
        board[0][1] = Rook.new('black')

        possible_attacks = rook.attacks_left(board, [0,3])
        
        expect(possible_attacks).to eq([[0,2]])

      end

      it "returns an array of [] when attacking from [0][3] and seeing no black pieces to the left" do

        board[0][3] = Rook.new('white')
        board[0][2] = Rook.new('white')

        possible_attacks = rook.attacks_left(board, [0,3])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][3] and seeing no black pieces to the left" do

        board[0][3] = Rook.new('white')
        board[0][2] = Rook.new('white')
        board[0][1] = Rook.new('black')

        possible_attacks = rook.attacks_left(board, [0,3])
        
        expect(possible_attacks).to eq([])

      end
    end
  end


  describe '#attacks_down' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:rook) {described_class.new('white')}

    context 'A White Rook looking for pieces to attack to downward' do

      it "returns an array of [5,0] when attacking from [3][0] and seeing a Black Rook at [5][0]" do

        board[3][0] = Rook.new('white')
        board[5][0] = Rook.new('black')
        board[6][0] = Rook.new('black')

        possible_attacks = rook.attacks_down(board, [3,0])
        
        expect(possible_attacks).to eq([[5,0]])

      end

      it "returns an array of [2,0] when attacking from [1][0] and seeing a Black Rook at [2][0] and [0][1]" do

        board[1][0] = Rook.new('white')
        board[2][0] = Rook.new('black')
        board[3][0] = Rook.new('black')

        possible_attacks = rook.attacks_down(board, [1,0])
        
        expect(possible_attacks).to eq([[2,0]])

      end

      it "returns an array of [] when attacking from [3][0] and seeing no black pieces downward" do

        board[3][0] = Rook.new('white')
        board[2][0] = Rook.new('white')

        possible_attacks = rook.attacks_down(board, [3,0])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [2][0] and seeing no black pieces downward" do

        board[2][0] = Rook.new('white')
        board[3][0] = Rook.new('white')
        board[4][0] = Rook.new('black')

        possible_attacks = rook.attacks_down(board, [2,0])
        
        expect(possible_attacks).to eq([])

      end
    end
  end
end
