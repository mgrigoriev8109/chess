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

#write tests for and fix King Movement Up
#write tests for and fix King Movement Up Right
#write additional test for Rook Movement Up from [7,4]
#write additional test for Bishop Movement Up Right from [7,0]

#write test for Pawn promotion, and then write code to pass test
#write test of King Castling, and then write code to pass test

#refactor #play_turn to have assessment of check/checkmate, enpassant, promotion, and castling each in their own methods
#stick check and checkmate into module
#stick en passant into module
#stick promotion into module
#stick castling into module

#implement simple computer AI that commits movements using simulated board logic to check possible Check attack
#allow player to choose playing vs player or computer
#implement save/load

#style the game properly
#go back through Sandi Met'z Testing video and make sure Tests are appropriate
#go back through POODR and think about possible ways of refactoring

#include gif and update README with finished project, features, bugs, reflections