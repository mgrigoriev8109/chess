#spec/crook_spec.rb
require 'current_game'
require 'player'

describe Rook do
  describe '#possible_movements' do
    context 'when a Player asks the Rook class for possible movements in a given location' do
      subject(:rook) {described_class.new}

      it "returns an array of all the possible spots the rook can move to" do
        expect (rook.possible_movements(current_game.board[0][0])) to_eq ()
      end
    end
  end
end
