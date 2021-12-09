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

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_instance_of(Rook)
      end
    end
  end

  describe '#available_row_movements' do
    context 'from [0][0] when other pieces are at [0][2]' do

      subject(:current_game) {described_class.new}
      current_game.board[0][2] = Rook.new('white')
      current_game.board[0][0] = Rook.new('black')
      current_location = current_game.board[0][0]

      available_movements = rook.available_row_movements(current_location)
      
      it "returns an array of the possible movements [0][1] and [1][0]" do
        expect (available_movements).to_eq([[0][1]])
      end

    end
  end
end