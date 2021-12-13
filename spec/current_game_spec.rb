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
        expect(current_game.board[0][0]).to be_instance_of(Rook)
      end

      it "returns false when an instance of Rook doesn't exist on that coordinate" do
        expect(current_game.board[0][0]).not_to be_instance_of(Rook)
      end
    end
  end

  describe '#verify_starting_location' do

    let(:player){instance_double(Player, starting_location: [0,0], color: 'white') } 
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

      it "returns true if a White Color Player checks whether White Rook is created at [0,0]" do

        current_game.create_starting_rooks

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_truthy
      end
      
      it "returns false if a Black Color Player checks whether White Rook is created at [0,0]" do

        current_game.create_starting_rooks

        verified_starting_location = current_game.verify_starting_location(player)
        
        expect(verified_starting_location).to be_truthy
      end
    end
  end
end