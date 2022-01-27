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

  describe '#attacks_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop looking for pieces to attack to the upper right' do

      it "returns an array of [0,1] when attacking from [1][0] and seeing a Black Bishop at [0][1]" do

        board[1][0] = Bishop.new('white')
        board[0][1] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_right(board, [1,0])
        
        expect(possible_attacks).to eq([[0,1]])

      end

      it "returns an array of [] when attacking from [4][1] and seeing no enemies" do

        board[4][1] = Bishop.new('white')

        possible_attacks = bishop.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [4][1] and seeing an unaccessable Black Bishop" do

        board[4][1] = Bishop.new('white')
        board[3][2] = Bishop.new('white')
        board[2][3] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [3,2] when attacking from [4][1] and seeing Black Bishops at [3,2] and [2,3]" do

        board[4][1] = Bishop.new('white')
        board[3][2] = Bishop.new('black')
        board[2][3] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([[3,2]])

      end
    end
  end

  describe '#attacks_down_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop looking for pieces to attack to the down right' do

      it "returns an array of [7,7] when attacking from [6][6] and seeing a Black Bishop at [7][7]" do

        board[6][6] = Bishop.new('white')
        board[7][7] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_right(board, [6,6])
        
        expect(possible_attacks).to eq([[7,7]])

      end

      it "returns an array of [] when attacking from [6][6] and seeing nothing" do

        board[6][6] = Bishop.new('white')

        possible_attacks = bishop.attacks_down_right(board, [6,6])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [5][5] and seeing a White Bishop in the way" do

        board[5][5] = Bishop.new('white')
        board[6][6] = Bishop.new('white')
        board[7][7] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_right(board, [5,5])
        
        expect(possible_attacks).to eq([])

      end
      
      it "returns an array of [6,6] when attacking from [5][5] and seeing Black Bishops at [6,6] and [7,7]" do

        board[5][5] = Bishop.new('white')
        board[6][6] = Bishop.new('black')
        board[7][7] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_right(board, [5,5])
        
        expect(possible_attacks).to eq([[6,6]])

      end
    end
  end

  describe '#attacks_up_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop looking for pieces to attack to the up left' do

      it "returns an array of [0,0] when attacking from [1][1] and seeing a Black Bishop at [0][0]" do

        board[1][1] = Bishop.new('white')
        board[0][0] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_left(board, [1,1])
        
        expect(possible_attacks).to eq([[0,0]])

      end

      it "returns an array of [1,0] when attacking from [2][1] and seeing a Black Bishop at [1][0]" do

        board[2][1] = Bishop.new('white')
        board[1][0] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_left(board, [2,1])
        
        expect(possible_attacks).to eq([[1,0]])

      end

      it "returns an array of [0,1] when attacking from [1][2] and seeing a Black Bishop at [0][1]" do

        board[1][2] = Bishop.new('white')
        board[0][1] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([[0,1]])

      end

      it "returns an array of [] when attacking from [1][2] and seeing no pieces" do

        board[1][2] = Bishop.new('white')

        possible_attacks = bishop.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [1][2] and seeing a White Bishop at [0][1]" do

        board[1][2] = Bishop.new('white')
        board[0][1] = Bishop.new('white')

        possible_attacks = bishop.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [1,2] when attacking from [2][3] and seeing a Black Bishop at [0][1] and [1][2]" do

        board[2][3] = Bishop.new('white')
        board[1][2] = Bishop.new('black')
        board[0][1] = Bishop.new('black')

        possible_attacks = bishop.attacks_up_left(board, [2,3])
        
        expect(possible_attacks).to eq([[1,2]])

      end
    end
  end

  describe '#attacks_down_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop looking for pieces to attack to the down left' do

      it "returns an array of [7,0] when attacking from [6][1] and seeing a Black Bishop at [7][0]" do

        board[6][1] = Bishop.new('white')
        board[7][0] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_left(board, [6,1])
        
        expect(possible_attacks).to eq([[7,0]])

      end

      it "returns an array of [5,2] when attacking from [0][7] and seeing a Black Bishop at [5][2]" do

        board[0][7] = Bishop.new('white')
        board[5][2] = Bishop.new('black')
        board[7][0] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([[5,2]])

      end

      it "returns an array of [] when attacking from [0][7] and seeing a White Bishop at [5][2]" do

        board[0][7] = Bishop.new('white')
        board[5][2] = Bishop.new('white')
        board[7][0] = Bishop.new('black')

        possible_attacks = bishop.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][7] and seeing no units to attack" do

        board[0][7] = Bishop.new('white')

        possible_attacks = bishop.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#all_possible_attacks' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'A White Bishop starting at [1,1]' do

      it "returns an attacking array of [[2, 0], [0, 2]] when two black Bishops and one white Bishop diagonal of it" do
        
        board[1][1] = Bishop.new('white')
        board[1][3] = Bishop.new('black')
        board[0][0] = Bishop.new('white')
        board[2][0] = Bishop.new('black')
        board[0][2] = Bishop.new('black')

        possible_attacks = bishop.all_possible_attacks(board, [1,1])

        expect(possible_attacks).to eq([[2, 0], [0, 2]])
      end
    end
  end

  describe '#find_diagonal_locations' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:bishop) {described_class.new('white')}

    context 'Returns all the possible up-left diagonal locations from a given location on the board' do

      it "returns [[2, 2], [1, 1], [0, 0]] as possible up left diagonal locations from [3,3]" do

        possible_diagonal = bishop.find_diagonal_locations([3,3])

        expect(possible_diagonal).to eq([[2, 2], [1, 1], [0, 0]])
      end
    end
  end
  
end