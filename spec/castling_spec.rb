#spec/castling_spec.rb
require 'current_game'

describe CurrentGame do

  describe '#possible_castling' do

    subject(:current_game) {described_class.new}
    context 'when a player asks the CurrentGame if a castling from starting to ending location possible' do

      it "returns true when the piece is a King attempting to move left or right two spaces from start" do
        current_game.board[0][4] = King.new('black')
        king_start = [0,4]
        king_castling_end = [0,2]

        can_king_move_castling = current_game.possible_castling(king_start, king_castling_end)
        
        expect(can_king_move_castling).to be true
      end

      it "returns true when the piece is a King attempting to move left or right two spaces from start" do
        current_game.board[7][4] = King.new('white')
        king_start = [7,4]
        king_castling_end = [7,6]

        can_king_move_castling = current_game.possible_castling(king_start, king_castling_end)
        
        expect(can_king_move_castling).to be true
      end

      it "returns false when the piece is a King attempting to move right one space from start" do
        current_game.board[7][4] = King.new('white')
        king_start = [7,4]
        king_castling_end = [7,5]

        can_king_move_castling = current_game.possible_castling(king_start, king_castling_end)
        
        expect(can_king_move_castling).to be false
      end
    end
  end
end