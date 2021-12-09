#spec/crook_spec.rb
require 'current_game'
require 'player'

describe Rook do
  describe '#find_possible_row_movements' do
    context 'from [0][0] when other pieces are at [0][2]' do

      subject(:rook) {described_class.new}
      let(:current_game) { instance_double(CurrentGame) }
      current_game.board[0][2] = Rook.new('white')
      current_game.board[0][0] = Rook.new('black')
      current_rook_location = current_game.board[0][0]

      row_movements = rook.possible_row_movements(current_rook_location)
      
      it "returns an array of the possible movements [0][1] and [1][0]" do
        expect (row_movements) to_eq([[0][1]])
      end

    end
  end
end
