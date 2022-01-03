#spec/castling_spec.rb
require 'current_game'

describe CurrentGame do

  describe '#move_castling_rook_left' do

    subject(:current_game) {described_class.new}
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do

      it "returns true when an instance of Rook exists on that coordinate" do


        current_game.move_castling_rook_left(color, current_game.board)
        
        expect(current_game.board[0][0]).to be_a Rook
      end
    end
  end
end