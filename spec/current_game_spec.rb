#spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'rook'

describe CurrentGame do
  describe '#create_starting_rooks' do
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do
      subject(:current_game) {described_class.new}

      it "returns true when an instance of Rook exists on that coordinate" do
        current_game.create_starting_rooks
        expect(current_game.board[0][0]).to be_instance_of(Rook)
      end

      it "returns false when an instanc of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_instance_of(Rook)
      end
    end
  end
end