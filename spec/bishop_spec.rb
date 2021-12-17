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

  describe '#movements_down_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'When a bishop is looking for possible down right diagonal movements' do

      it "from [6,6] returns an array of [[7,7]] when stopping at the bottom right board corner" do

        board[6][6] = Bishop.new('white')

        possible_movements = bishop.movements_down_right(board, [6,6])
        
        expect(possible_movements).to eq([[7,7]])

      end

      it "from [5,5] returns an array of [[6,6],[7,7]] when stopping at the bottom right board corner" do

        board[5][5] = Bishop.new('white')

        possible_movements = bishop.movements_down_right(board, [5,5])
        
        expect(possible_movements).to eq([[6,6],[7,7]])

      end

      it "from [4,5] returns an array of [[5,6],[6,7]] when stopping at the bottom right board corner" do

        board[4][5] = Bishop.new('white')

        possible_movements = bishop.movements_down_right(board, [4,5])
        
        expect(possible_movements).to eq([[5,6],[6,7]])

      end

      it "from [4,4] returns an array of [[5,5]] when stopping at a White Bishop at [6][6]" do

        board[4][4] = Bishop.new('white')
        board[6][6] = Bishop.new('white')

        possible_movements = bishop.movements_down_right(board, [4,4])
        
        expect(possible_movements).to eq([[5,5]])

      end
    end
  end

  describe '#movements_up_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'When a bishop is looking for possible up left diagonal movements' do

      it "from [1,1] returns an array of [[0,0]] when stopping at top left board corner" do

        board[1][1] = Bishop.new('white')

        possible_movements = bishop.movements_up_left(board, [1,1])
        
        expect(possible_movements).to eq([[0,0]])

      end

      it "from [3,3] returns an array of [[2,2]] when stopping at a White Bishop at [1][1]" do

        board[3][3] = Bishop.new('white')
        board[1][1] = Bishop.new('white')

        possible_movements = bishop.movements_up_left(board, [3,3])
        
        expect(possible_movements).to eq([[2,2]])

      end

      it "from [4,5] returns an array of [[2, 3], [3, 4]] when stopping at a White Bishop at [1][2]" do

        board[4][5] = Bishop.new('white')
        board[1][2] = Bishop.new('white')

        possible_movements = bishop.movements_up_left(board, [4,5])
        
        expect(possible_movements).to eq([[2, 3], [3, 4]])

      end

      it "from [2,1] returns an array of [[1,0]] when stopping at the left board edge" do

        board[2][1] = Bishop.new('white')

        possible_movements = bishop.movements_up_left(board, [2,1])
        
        expect(possible_movements).to eq([[1,0]])

      end

      it "from [4,3] returns an array of [[3,2]] when stopping at a White Bishop at [2,1]" do

        board[4][3] = Bishop.new('white')
        board[2][1] = Bishop.new('white')

        possible_movements = bishop.movements_up_left(board, [4,3])
        
        expect(possible_movements).to eq([[3,2]])

      end
    end
  end

  describe '#movements_down_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'When a bishop is looking for possible down left diagonal movements' do

      it "from [6,1] returns an array of [[7,0]] when stopping at the bottom left board corner" do

        board[6][1] = Bishop.new('white')

        possible_movements = bishop.movements_down_left(board, [6,1])
        
        expect(possible_movements).to eq([[7,0]])

      end

      it "from [6,6] returns an array of [[7,5]] when stopping at the bottom board edge" do

        board[6][6] = Bishop.new('white')

        possible_movements = bishop.movements_down_left(board, [6,6])
        
        expect(possible_movements).to eq([[7,5]])

      end

      it "from [4,2] returns an array of [[5, 1], [6, 0]] when stopping at the left board edge" do

        board[4][2] = Bishop.new('white')

        possible_movements = bishop.movements_down_left(board, [4,2])
        
        expect(possible_movements).to eq([[5, 1], [6, 0]])

      end

      it "from [2,3] returns an array of [[3,2]] when stopping at a White Bishop at [4,1]" do

        board[2][3] = Bishop.new('white')
        board[4][1] = Bishop.new('white')

        possible_movements = bishop.movements_down_left(board, [2,3])
        
        expect(possible_movements).to eq([[3,2]])

      end
    end
  end

  describe '#all_possible_movements' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop starting' do

      it "at [1,1] returns an array of [[0,1],[0,2],[1,0],[2,0]] when another White Bishop is at [3,3]" do
        
        board[1][1] = Bishop.new('white')
        board[3][3] = Bishop.new('white')

        possible_movements = bishop.all_possible_movements(board, [1,1])

        expect(possible_movements).to eq([[2, 0], [2, 2], [0, 0], [0, 2]])
      end

      it "at [1,2] returns an array of [[0,1],[0,2],[1,0],[2,0]] when another White Bishop is at [2,3]" do
        
        board[1][2] = Bishop.new('white')
        board[2][3] = Bishop.new('white')

        possible_movements = bishop.all_possible_movements(board, [1,2])

        expect(possible_movements).to eq([[2, 1], [3, 0], [0, 1], [0, 3]])
      end
    end
  end
end