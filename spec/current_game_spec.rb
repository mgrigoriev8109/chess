#spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'rook'

describe CurrentGame do

  describe '#create_starting_rooks' do

    subject(:current_game) {described_class.new}
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do

      it "returns true when an instance of Rook exists on that coordinate" do
        current_game.create_starting_rooks
        expect(current_game.board[0][0]).to be_instance_of(Rook)
      end

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_instance_of(Rook)
      end
    end
  end

  describe '#row_movements' do

    subject(:current_game) {described_class.new}
    context 'from [0,1]' do

      it "returns an array of [[0,2]] when stopping at [0][3]" do

      current_game.board[0][3] = Rook.new('white')
      current_game.board[0][1] = Rook.new('black')

      rook_row_movements = current_game.rook_row_movements([0,1])
      
      expect(rook_row_movements).to eq([[0,2]])
      end

      it "returns an array of [[0,2][0,3]] when stopping at [0][4]" do

      current_game.board[0][4] = Rook.new('white')
      current_game.board[0][1] = Rook.new('black')

      rook_row_movements = current_game.rook_row_movements([0,1])
      
      expect(rook_row_movements).to eq([[0,2],[0,3]])
      end
  
      it "returns possible moves of [[0,0][0,2][0,3]] when stopping at [0][4] and left board edge" do

        current_game.board[0][4] = Rook.new('white')
        current_game.board[0][1] = Rook.new('black')
  
        rook_row_movements = current_game.rook_row_movements([0,1])
        
        expect(rook_row_movements).to eq([[0,0],[0,2],[0,3]])
        end
    
    end
  end
end