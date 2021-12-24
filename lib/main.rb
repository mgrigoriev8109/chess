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