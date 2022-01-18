require_relative 'current_game'
require_relative 'player'

  current_game = CurrentGame.new
  current_game.introduction
  current_game.populate_gameboard
  puts "What will be the name of the White Player? If this player is to be a computer, type the name Computer"
  white_player = current_game.create_player("white")
  puts "What will be the name of the Black Player? If this player is to be a computer, type the name Computer"
  black_player = current_game.create_player("black")
  current_game.show_display

until current_game.assess_endofgame('black', current_game.board) do 

  if white_player.name == 'Computer'
    current_game.computer_turn(white_player)
  else
    current_game.human_turn(white_player)
  end

  break if current_game.assess_endofgame('white', current_game.board)

  if black_player.name == 'Computer'
    current_game.computer_turn(black_player)
  else
    current_game.human_turn(black_player)
  end
end

#implement save/load
#style chess properly
#go back through POODR and think about possible ways of refactoring to make it more OOP
#include gif and update README with finished project, features, bugs, reflections