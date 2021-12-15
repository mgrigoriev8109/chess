#spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'rook'

describe CurrentGame do

  describe '#create_starting_rooks' do

    subject(:current_game) {described_class.new}
    context 'when a player asks the CurrentGame if a Rook exists on the @board' do

      it "returns true when an instance of Rook exists on that coordinate" do
        current_game.create_starting_rooks
        expect(current_game.board[0][0]).to be_a Rook
      end

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_a Rook
      end
    end
  end

  describe '#verify_starting_location' do

    let(:player){instance_double(Player, starting_location: [0,0], color: 'black') } 
    subject(:current_game) {described_class.new}

    context 'When verifying a starting location of [0.0]' do

      it "returns false if the no pieces have been created on the board" do

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_falsy
      end

      it "returns false if the Rook at [0,0] created, and then deleted" do

        current_game.create_starting_rooks
        current_game.board[0][0] = " "

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_falsy
      end

      it "returns true if a Black Color Player finds that a Black Rook is at [0,0]" do

        current_game.create_starting_rooks

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_truthy
      end
      
      it "returns false if a Black Color Player finds that a White Rook is at [0,0]" do

        current_game.create_starting_rooks
        current_game.board[0][0] = Rook.new('white')

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_falsy
      end
    end
  end

  describe '#move_gamepiece' do

    let(:player){instance_double(Player, color: 'white', name: 'player', starting_location: [0,0], ending_location: [1,0]) } 
    subject(:current_game) {described_class.new}

    context 'When moving a Black Rook from A8, aka [0,0] aka [0][0]' do

      it "the board will return a Black Rook at A7, aka [1.0], aka [1][0]" do
        
        current_game.board[0][0] = Rook.new('black')
        current_game.move_gamepiece(player)

        ending_coordinates = current_game.board[1][0]
        
        expect(ending_coordinates).to be_a Rook
      end

      it "and also return empty space ' ' at [0][0]" do

        current_game.board[0][0] = Rook.new('black')
        current_game.move_gamepiece(player)

        starting_coordinates = current_game.board[0][0]
        
        expect(starting_coordinates).to eq(' ')
      end
    end
  end
end