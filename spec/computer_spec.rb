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

      it "includes a random movement's ending coordinates within the overall array of possible movements that piece has" do

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

  describe '#find_computer_attack' do

    subject(:current_game) {described_class.new}
    context 'When determining a possible attack by a Computer' do

      it "includes a random attack's ending coordinates within the overall array of possible attacks" do

        current_game.board[3][0] = Rook.new("black")
        current_game.board[4][0] = Rook.new("white")
        current_game.board[3][1] = Rook.new("white")
        computer_color = 'black'
        black_rook = current_game.board[3][0]
        possible_rook_attacks = black_rook.all_possible_attacks(current_game.board, [3,0])

        found_attack = current_game.find_computer_attack(computer_color, current_game.board)
        ending_coordinates = [found_attack[2], found_attack[3]]

        expect(possible_rook_attacks).to include(ending_coordinates)
      end
    end
  end

  describe '#find_computer_check' do

    subject(:current_game) {described_class.new}
    context 'When determining a possible check-resulting move by a Computer' do

      it "returns [3,0] as the movement a Rook can make from [3,1] to put a king into checks" do

        current_game.board[3][1] = Rook.new("black")
        current_game.board[4][0] = King.new("white")
        computer_color = 'black'

        found_check = current_game.find_computer_check(computer_color, current_game.board)
        check_movement_ending = [found_check[2], found_check[3]]

        expect(check_movement_ending).to eq([4,1])
      end
    end
  end
end
