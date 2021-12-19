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
end
