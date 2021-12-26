require_relative 'current_game'

current_game = CurrentGame.new
current_game.introduction
current_game.populate_gameboard
white_player = current_game.create_player("white")
black_player = current_game.create_player("black")
current_game.display

until current_game.assess_endofround_checkmate(black_player) do 
  current_game.play_turn(white_player)
  break if current_game.assess_endofround_checkmate(white_player)
  current_game.play_turn(black_player)
end

#modify BlackPawn's methods to match correct direction
#write tests to check WhitePawn's En Passant attack
#write tests to check all of BlackPawn's movements and attacks (can duplicate WhitePawn pretty much entirely)
#write tests for CurrentGame's #verify_enpassant_by_white_pawn and #...by_black_pawn
#write tests for CurrentGame's #assess_endofround_enpassant
#play a game from beginning to end to make sure nothing is clearly broken
#add any possible code needed to play game properly 
#write code for Pawn promotion
#test Pawn promotion
#write code of King Castling
#test King Castling

#stick check and checkmate into module
#stick en passant into module
#stick promotion into module
#stick castling into module

#implement save/load

#style the game properly
#go back through Sandi Met'z Testing video and make sure Tests are appropriate
#go back through POODR and think about possible ways of refactoring