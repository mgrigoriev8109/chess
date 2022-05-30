# spec/player_spec.rb
require 'player'

describe Player do
  describe '#letter_to_numbers' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'When transforming player inputs from A to H' do
      it 'returns 0 as the corresponding row for A on the Chessboard' do
        input_letter = 'A'

        transformed_letter = player.letter_to_numbers(input_letter)

        expect(transformed_letter).to eq(0)
      end

      it 'returns 2 as the corresponding row for C on the Chessboard' do
        input_letter = 'C'

        transformed_letter = player.letter_to_numbers(input_letter)

        expect(transformed_letter).to eq(2)
      end

      it 'returns 7 as the corresponding row for H on the Chessboard' do
        input_letter = 'H'

        transformed_letter = player.letter_to_numbers(input_letter)

        expect(transformed_letter).to eq(7)
      end
    end
  end

  describe '#starting_location' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'when Player inputs a starting location with LetterNumber format' do
      it 'returns coordinate notation [0,0] for the input algebraic notation location A8A8' do
        player.alg_notation = 'A8A8'

        coordinate_notation = player.starting_location

        expect(coordinate_notation).to eq([0, 0])
      end

      it 'returns coordinate notation [1,5] for the input algebraic notation location A8A8' do
        player.alg_notation = 'B3A8'

        coordinate_notation = player.starting_location

        expect(coordinate_notation).to eq([5, 1])
      end

      it 'returns coordinate notation [3,6] for the input algebraic notation location G2A8' do
        player.alg_notation = 'G2A8'

        coordinate_notation = player.starting_location

        expect(coordinate_notation).to eq([6, 6])
      end
    end
  end

  describe '#ending_location' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'when Player inputs a ending location with LetterNumber format' do
      it 'returns coordinate notation [2,0] for the input algebraic notation location A8C8' do
        player.alg_notation = 'A8C8'

        coordinate_notation = player.ending_location

        expect(coordinate_notation).to eq([0, 2])
      end

      it 'returns coordinate notation [7,7] for the input algebraic notation location A8H1' do
        player.alg_notation = 'A8H1'

        coordinate_notation = player.ending_location

        expect(coordinate_notation).to eq([7, 7])
      end

      it 'returns coordinate notation [3,6] for the input algebraic notation location G2D2' do
        player.alg_notation = 'G2D2'

        coordinate_notation = player.ending_location

        expect(coordinate_notation).to eq([6, 3])
      end
    end
  end
  describe '#movement' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'When transforming alg_notation to coordinate notation' do
      it 'returns [0,0,1,1] as the corresponding coordinates for A8 to B7' do
        player.alg_notation = %w[A 8 B 7]

        transformed_coordinates = player.movement

        expect(transformed_coordinates).to eq([0, 0, 1, 1])
      end
    end
  end

  describe '#get_algebraic_notation' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'When transforming coordinate notation to algebraic notation' do
      it 'returns A8 to B7 from the movement notation of [0,0,1,1' do
        movement = [0, 0, 1, 1]
        alg_notation = 'A8B7'

        transformed_notation = player.get_algebraic_notation(movement)

        expect(transformed_notation).to eq(alg_notation)
      end
    end
  end

  describe '#verify_input' do
    subject(:player) { described_class.new('white', 'test_player') }
    context 'When transforming coordinate notation to algebraic notation' do
      it "returns true because the input ['A','8','B','5'] is verified as proper chess algebraic notation" do
        player.alg_notation = %w[A 8 B 5]

        input_verified = player.verify_input

        expect(input_verified).to be true
      end

      it "returns false because the input ['A','9','B','5'] is verified as proper chess algebraic notation" do
        player.alg_notation = %w[A 9 B 5]

        input_verified = player.verify_input

        expect(input_verified).to be false
      end
    end
  end
end
