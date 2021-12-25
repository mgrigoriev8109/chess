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

#then continue on to create the Queen (simply copy Rook and Bishop logic)
#then continue on to create the Knight (follow same movement/attack logic conceptually
  #as the Rook and Bishop)
#then continue on to create the Black Pawn and White Pawn