#spec/computer_game_spec.rb
require 'computer'
require 'current_game'
require 'player'
require 'rook'
require 'king'
require 'bishop'

describe CurrentGame do

  describe '#find_computer_move' do

    subject(:current_game) {described_class.new}
    context 'When determining a possible move by a Computer' do

      it "returns [3, 0, 3, 1] as forward movement for a Black Rook standing at [3,0]" do

        current_game.board[3][0] = Rook.new("black")
        computer_color = 'black'
        black_rook = current_game.board[3][0]
        possible_rook_movements = black_rook.all_possible_movements(current_game.board, [3,0])

        found_movement = current_game.find_computer_move(computer_color, current_game.board)
        ending_coordinates = [found_movement[2], found_movement[3]]

        expect(possible_rook_movements).to include(ending_coordinates)
      end
    end
  end
end
