#spec/knight_spec.rb
require 'knight'
require 'current_game'

describe Knight do

  describe '#movements_up_right' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:knight) {described_class.new('white')}

    context 'When a knight is looking for possible movement 2 squares up and 1 square right' do

      it "from [3,3] returns an array of [[1,4]] when [1,4] is empty" do

        board[3][3] = Knight.new('white')

        possible_movement = knight.movements_up_right(board, [3,3])
        
        expect(possible_movement).to eq([[1,4]])
      end

      it "from [3,3] returns an array of [] when there is a piece at [1,4]" do

        board[3][3] = Knight.new('white')
        board[1][4] = Knight.new('white')

        possible_movement = knight.movements_up_right(board, [3,3])
        
        expect(possible_movement).to eq([])
      end

      it "from [0,7] returns an array [] due to no possible movements" do

        board[0][7] = Knight.new('white')

        possible_movement = knight.movements_up_right(board, [0,7])
        
        expect(possible_movement).to eq([])
      end
    end
  end

  describe '#movements_up_left' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:knight) {described_class.new('white')}

    context 'When a knight is looking for possible movement 2 squares up and 1 square left' do

      it "from [3,3] returns an array of [[1,2]] when [1,2] is empty" do

        board[3][3] = Knight.new('white')

        possible_movement = knight.movements_up_left(board, [3,3])
        
        expect(possible_movement).to eq([[1,2]])
      end

      it "from [3,3] returns an array of [] when there is a piece at [1,2]" do

        board[3][3] = Knight.new('white')
        board[1][2] = Knight.new('white')

        possible_movement = knight.movements_up_left(board, [3,3])
        
        expect(possible_movement).to eq([])
      end

      it "from [0,0] returns an array [] due to no possible movements" do

        board[0][0] = Knight.new('white')

        possible_movement = knight.movements_up_left(board, [0,7])
        
        expect(possible_movement).to eq([])
      end
    end
  end

  describe '#movements_right_up' do

    let(:board){Array.new(8) { Array.new(8, " ") } }
    subject(:knight) {described_class.new('white')}

    context 'When a knight is looking for possible movement 2 squares right and 1 square up' do

      it "from [3,3] returns an array of [[2,5]] when [2,5] is empty" do

        board[3][3] = Knight.new('white')

        possible_movement = knight.movements_right_up(board, [3,3])
        
        expect(possible_movement).to eq([[2,5]])
      end

    end
  end
end
