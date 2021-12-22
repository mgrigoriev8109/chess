require_relative 'current_game'

current_game = CurrentGame.new
current_game.introduction
current_game.populate_gameboard
white_player = current_game.create_player("white")
black_player = current_game.create_player("black")
current_game.display

until current_game.checkmate do 
  current_game.play_turn(white_player)
  break if current_game.checkmate
  current_game.play_turn(black_player)
end

#How to go about testing this (most tests should only need refactoring/rewording):
#1) test Player's new #movement method
#2) test CurrentGame's #get_king_location
#3) test CurrentGame's #get_all_attacks_against
#4) test CurrentGame's #verify_check
#5) test CurrentGame's #move_gamepiece
#6) test CurrentGame's #get_piece
#7) test CurrentGame's #verify_end
  #- make sure that king can't move into a check position
  #- make sure king can't attack into a check position
  #- make sure king CAN attack regular piece out of a check position
  #- make sure player's same color rook can't move into a check position
  #- make sure player's same color rook can't attack into a check position
  #- make sure player's same color rook can move in front of king to get king out of check
#8) test CurrentGame's #verify_start
#9) test CurrentGame's #verify_movement

#then continue on to create the following methods:
#1) CurrentGame's #assess_endofround_checkmate
  #- this will check if a player's opponent king has any possible movements
  #- it can use duplicate code from #verify_end to run a simulated board to verify checks
#2) CurrentGame's #assess_endofround_check
  #- this will check if a player's opponent king is in #verify_check

#then continue on to create the Queen (simply copy Rook and Bishop logic)
#then continue on to create the Knight (follow same movement/attack logic conceptually
  #as the Rook and Bishop)
#then continue on to create the Black Pawn and White Pawn
  #think about how to encorporate EnPassant