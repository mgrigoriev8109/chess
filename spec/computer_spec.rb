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

      it "returns [4,1] as the movement a Rook can make from [3,1] to put a king into checks" do

        current_game.board[3][1] = Rook.new("black")
        current_game.board[4][0] = King.new("white")
        computer_color = 'black'

        found_check = current_game.find_computer_check(computer_color, current_game.board)
        check_movement_ending = [found_check[2], found_check[3]]

        expect(check_movement_ending).to eq([4,1])
      end
    end
  end

  describe '#find_computer_checkmate' do

    subject(:current_game) {described_class.new}
    context 'When determining a possible checkmate-resulting move by a Computer' do

      it "returns [4,5] as the movement a Rook can make from [3,5] to put a king into checkmates" do

        current_game.board[3][2] = Rook.new("black")
        current_game.board[3][5] = Rook.new("black")
        current_game.board[5][5] = Rook.new("black")
        current_game.board[4][0] = King.new("white")
        computer_color = 'black'

        found_checkmate = current_game.find_computer_checkmate(computer_color, current_game.board)
        checkmate_movement_ending = [found_checkmate[2], found_checkmate[3]]

        expect(checkmate_movement_ending).to eq([4,5])
      end
    end
  end

  describe '#determine_computer_movement' do

    subject(:current_game) {described_class.new}
    context 'When determining which movement a Computer will prioritize' do

      it "returns [0,3,4,7] as the Queen's checkmate movement by Black of a Fool's Blunder" do

        current_game.populate_gameboard
        current_game.move_gamepiece([6,5],[5,5],current_game.board)
        current_game.move_gamepiece([1,4],[2,4],current_game.board)
        current_game.move_gamepiece([6,6],[4,6],current_game.board)
        current_computer_color = 'black'

        fools_blunder_checkmate = current_game.determine_computer_movement(current_computer_color, current_game.board)

        expect(fools_blunder_checkmate).to eq([0,3,4,7])
      end

      it "returns a four digit long array for the computer movement" do

        current_game.populate_gameboard
        current_computer_color = 'white'

        computer_movement_array = current_game.determine_computer_movement(current_computer_color, current_game.board)


        expect(computer_movement_array.count).to eq(4)
      end
    end
  end
end
