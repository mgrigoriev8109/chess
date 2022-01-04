require_relative 'current_game'

current_game = CurrentGame.new
current_game.introduction
current_game.populate_gameboard
puts "What is the name of the White Player?"
white_player = current_game.create_player("white")
puts "What is the name of the Black Player?"
black_player = current_game.create_player("black")
current_game.display

until current_game.assess_endofround_checkmate('black', current_game.board) do 
  current_game.play_turn(white_player)
  break if current_game.assess_endofround_checkmate('white', current_game.board)
  current_game.play_turn(black_player)
end

#write tests for Castling's #possible_castling
#write tests for Castling's #possible_check_movements
#write tests for Castling's #king_ends_in_check
#write tests for Castling's #pieces_between_king_rook
#write tests for Castling's #player_can_castle
#write tests for Castling's #can_next_player_castle
#write tests for Castling's #move_castling_rook_right
#write tests for Castling's #move_castling_rook_left
#write tests for Castling's #move_castling_rook

#play some rounds of Chess to test for EnPassant and Castling functionality

#implement simple computer AI that commits movements using simulated board logic to check possible Check attack
#allow player to choose playing vs player or computer
#implement save/load

#style the game properly
#go back through POODR and think about possible ways of refactoring

#include gif and update README with finished project, features, bugs, reflections