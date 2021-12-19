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

  describe '#attacks_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the right' do

      it "returns an array of [0,1] when attacking from [0][0] and seeing a Black King at [0][1]" do

        board[0][0] = King.new('white')
        board[0][1] = King.new('black')

        possible_attacks = king.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([[0,1]])

      end

      it "returns an array of [] when attacking from [0][0] and seeing a Black King at [0][2]" do

        board[0][0] = King.new('white')
        board[0][2] = King.new('black')

        possible_attacks = king.attacks_right(board, [0,0])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][1] and seeing a Black King at [0][3]" do

        board[0][0] = King.new('wblack')
        board[0][1] = King.new('white')
        board[0][3] = King.new('black')

        possible_attacks = king.attacks_right(board, [0,1])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#attacks_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the left' do

      it "returns an array of [0,2] when attacking from [0][3] and seeing a Black King at [0][2]" do

        board[0][3] = King.new('white')
        board[0][2] = King.new('black')
        board[0][4] = King.new('black')

        possible_attacks = king.attacks_left(board, [0,3])
        
        expect(possible_attacks).to eq([[0,2]])

      end

      it "returns an array of [] when attacking from [0][4] and seeing a Black King at [0][2]" do

        board[0][2] = King.new('black')
        board[0][4] = King.new('white')

        possible_attacks = king.attacks_left(board, [0,4])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#attacks_down' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the left' do

      it "returns an array of [1,0] when attacking from [0][0] and seeing a Black King at [1][0]" do

        board[0][0] = King.new('white')
        board[1][0] = King.new('black')
        board[2][0] = King.new('black')

        possible_attacks = king.attacks_down(board, [0,0])
        
        expect(possible_attacks).to eq([[1,0]])

      end

      it "returns an array of [] when attacking from [0][0] and seeing a Black King at [2][0]" do

        board[0][0] = King.new('black')
        board[2][0] = King.new('white')

        possible_attacks = king.attacks_down(board, [0,0])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#attacks_up' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the left' do

      it "returns an array of [2,2] when attacking from [3][2] and seeing a Black King at [2][2]" do

        board[3][2] = King.new('white')
        board[2][2] = King.new('black')
        board[1][2] = King.new('black')

        possible_attacks = king.attacks_up(board, [3,2])
        
        expect(possible_attacks).to eq([[2,2]])

      end

      it "returns an array of [] when attacking from [3][2] and seeing a Black King at [1][2]" do

        board[3][2] = King.new('black')
        board[1][2] = King.new('white')

        possible_attacks = king.attacks_up(board, [3,2])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

  describe '#attacks_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the upper right' do

      it "returns an array of [0,1] when attacking from [1][0] and seeing a Black King at [0][1]" do

        board[1][0] = King.new('white')
        board[0][1] = King.new('black')

        possible_attacks = king.attacks_up_right(board, [1,0])
        
        expect(possible_attacks).to eq([[0,1]])

      end

      it "returns an array of [] when attacking from [4][1] and seeing no enemies" do

        board[4][1] = King.new('white')

        possible_attacks = king.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [4][1] and seeing a too far away Black King" do

        board[4][1] = King.new('white')
        board[2][3] = King.new('black')

        possible_attacks = king.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [3,2] when attacking from [4][1] and seeing Black Kings at [3,2] and [2,3]" do

        board[4][1] = King.new('white')
        board[3][2] = King.new('black')
        board[2][3] = King.new('black')

        possible_attacks = king.attacks_up_right(board, [4,1])
        
        expect(possible_attacks).to eq([[3,2]])

      end
    end
  end

  describe '#attacks_down_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the down right' do

      it "returns an array of [7,7] when attacking from [6][6] and seeing a Black King at [7][7]" do

        board[6][6] = King.new('white')
        board[7][7] = King.new('black')

        possible_attacks = king.attacks_down_right(board, [6,6])
        
        expect(possible_attacks).to eq([[7,7]])

      end

      it "returns an array of [] when attacking from [6][6] and seeing nothing" do

        board[6][6] = King.new('white')

        possible_attacks = king.attacks_down_right(board, [6,6])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [5][5] and seeing a Black King too far way" do

        board[5][5] = King.new('white')
        board[7][7] = King.new('black')

        possible_attacks = king.attacks_down_right(board, [5,5])
        
        expect(possible_attacks).to eq([])

      end
      
      it "returns an array of [6,6] when attacking from [5][5] and seeing Black Kings at [6,6] and [7,7]" do

        board[5][5] = King.new('white')
        board[6][6] = King.new('black')
        board[7][7] = King.new('black')

        possible_attacks = king.attacks_down_right(board, [5,5])
        
        expect(possible_attacks).to eq([[6,6]])

      end
    end
  end

  describe '#attacks_up_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the up left' do

      it "returns an array of [0,0] when attacking from [1][1] and seeing a Black King at [0][0]" do

        board[1][1] = King.new('white')
        board[0][0] = King.new('black')

        possible_attacks = king.attacks_up_left(board, [1,1])
        
        expect(possible_attacks).to eq([[0,0]])

      end

      it "returns an array of [1,0] when attacking from [2][1] and seeing a Black King at [1][0]" do

        board[2][1] = King.new('white')
        board[1][0] = King.new('black')

        possible_attacks = king.attacks_up_left(board, [2,1])
        
        expect(possible_attacks).to eq([[1,0]])

      end

      it "returns an array of [0,1] when attacking from [1][2] and seeing a Black King at [0][1]" do

        board[1][2] = King.new('white')
        board[0][1] = King.new('black')

        possible_attacks = king.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([[0,1]])

      end

      it "returns an array of [] when attacking from [1][2] and seeing no pieces" do

        board[1][2] = King.new('white')

        possible_attacks = king.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [1][2] and seeing a White King at [0][1]" do

        board[1][2] = King.new('white')
        board[0][1] = King.new('white')

        possible_attacks = king.attacks_up_left(board, [1,2])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [1,2] when attacking from [2][3] and seeing a Black King at [0][1] and [1][2]" do

        board[2][3] = King.new('white')
        board[1][2] = King.new('black')
        board[0][1] = King.new('black')

        possible_attacks = king.attacks_up_left(board, [2,3])
        
        expect(possible_attacks).to eq([[1,2]])

      end
    end
  end

  describe '#attacks_down_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:king) {described_class.new('white')}

    context 'A White King looking for pieces to attack to the down left' do

      it "returns an array of [7,0] when attacking from [6][1] and seeing a Black King at [7][0]" do

        board[6][1] = King.new('white')
        board[7][0] = King.new('black')

        possible_attacks = king.attacks_down_left(board, [6,1])
        
        expect(possible_attacks).to eq([[7,0]])

      end

      it "returns an array of [] when attacking from [0][7] and seeing a Black King too far away" do

        board[0][7] = King.new('white')
        board[5][2] = King.new('black')

        possible_attacks = king.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][7] and seeing a White King at [5][2]" do

        board[0][7] = King.new('white')
        board[5][2] = King.new('white')
        board[7][0] = King.new('black')

        possible_attacks = king.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([])

      end

      it "returns an array of [] when attacking from [0][7] and seeing no units to attack" do

        board[0][7] = King.new('white')

        possible_attacks = king.attacks_down_left(board, [0,7])
        
        expect(possible_attacks).to eq([])

      end
    end
  end

end
