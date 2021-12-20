#spec/current_game_spec.rb
require 'current_game'
require 'player'
require 'rook'
require 'king'
require 'bishop'

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

  describe '#verify_ending_location' do

    let(:player){instance_double(Player, color: 'black', name: 'player', starting_location: [0,0], ending_location: [1,0]) } 
    subject(:current_game) {described_class.new}

    context 'When moving a Black Rook and checking availability of the ending location' do

      it "will return true when moving a Black Rook from [0][0] to an empty space at [1][0]" do
        
        current_game.board[0][0] = Rook.new('black')

        ending_location_verification = current_game.verify_ending_location(player)
        
        expect(ending_location_verification).to be true
      end

      it "will return false when moving Black Rook from [0][0] to attack a Black Rook at [1][0]" do
        
        current_game.board[0][0] = Rook.new('black')
        current_game.board[1][0] = Rook.new('black')

        ending_location_verification = current_game.verify_ending_location(player)
        
        expect(ending_location_verification).to be false
      end

      it "will return true when moving a Black Rook from [0][0] to attack a White Rook at [1][0]" do
        
        current_game.board[0][0] = Rook.new('black')
        current_game.board[1][0] = Rook.new('white')

        ending_location_verification = current_game.verify_ending_location(player)
        
        expect(ending_location_verification).to be true
      end
    end
  end

  describe '#verify_check' do

    let(:attacking_player){instance_double(Player, color: 'black', name: 'player') } 
    subject(:current_game) {described_class.new}

    context 'When checking if the attacking Black player can perform Check on a White King piece' do

      it "returns true when Black has a Rook [0,2] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[0][2] = Rook.new('black')

        is_player_performing_check = current_game.verify_check(attacking_player)
        
        expect(is_player_performing_check).to be true
      end

      it "returns true when Black has a Bishop [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = Bishop.new('black')

        is_player_performing_check = current_game.verify_check(attacking_player)
        
        expect(is_player_performing_check).to be true
      end

      it "returns true when Black has a King [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = King.new('black')

        is_player_performing_check = current_game.verify_check(attacking_player)
        
        expect(is_player_performing_check).to be true
      end

      it "returns false when Black has a Rook [1,1] adjescent to a White King [0,0]" do
        
        current_game.board[0][0] = King.new('white')
        current_game.board[1][1] = Rook.new('black')

        is_player_performing_check = current_game.verify_check(attacking_player)
        
        expect(is_player_performing_check).to be false
      end
    end
  end
end