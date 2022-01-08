require_relative 'current_game'

current_game = CurrentGame.new
current_game.introduction
current_game.populate_gameboard
puts "What will be the name of the White Player? If this player is to be a computer, type the name Computer"
white_player = current_game.create_player("white")
puts "What will be the name of the Black Player? If this player is to be a computer, type the name Computer"
black_player = current_game.create_player("black")
current_game.display

until current_game.assess_endofround_checkmate('black', current_game.board) do 

  if white_player.is_a?(Player)
    current_game.human_turn(white_player)
  else
    current_game.computer_turn(white_player)
  end

  break if current_game.assess_endofround_checkmate('white', current_game.board)

  if black_player.is_a?(Player)
    current_game.human_turn(black_player)
  else
    current_game.computer_turn(black_player)
  end
end

#implement simple computer AI that randomly generated movements based off of possible movements

#review 3 git lessons linked in MD file
#write rough draft for advanced git lessons outline point 1)

#add AI feature to perform a movement using simulated board logic to if that movement results in check or checkmate

#write rough draft for advanced git lessons outline point 2)

#allow player to choose playing vs player or computer

#write rough draft for advanced git lessons outline point 3)

#implement save/load

#write rough draft for advanced git lessons outline point 4)
#assess timeline, if it's already January 20th, then write rough draft for point 5) next

#if it's earlier than 20th, then before point 5)
#hunt for bugs, have AI play against each other, test castling and en passant in-game. 

#style chess properly

#revise rough draft into final draft and create pull request

#go back through POODR and think about possible ways of refactoring to make it more OOP
#include gif and update README with finished project, features, bugs, reflections