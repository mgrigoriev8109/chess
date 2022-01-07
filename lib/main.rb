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

#create outline for git lesson and modify this list with goals

#implement simple computer AI that randomly generated movements
#add AI feature to perform a movement using simulated board logic to if that movement results in check or checkmate
#allow player to choose playing vs player or computer

#implement save/load

#hunt for bugs, have AI play against each other, test castling and en passant in-game. 

#style the game properly
#go back through POODR and think about possible ways of refactoring to make it more OOP
#include gif and update README with finished project, features, bugs, reflections