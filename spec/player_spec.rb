#spec/rook_spec.rb
require 'player'

describe Player do
  describe '#letter_to_numbers' do

    subject(:player) {described_class.new('white', 'test_player')}
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
end