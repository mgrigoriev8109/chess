require_relative 'current_game'
require_relative 'player'

10.times do
  current_game = CurrentGame.new
  current_game.populate_gameboard
  puts "Welcome to a CLI game of Chess!"
  puts "What will be the name of the White Player? If this player is to be a computer, type the name Computer"
  #white_player = current_game.create_player("white")
  puts "What will be the name of the Black Player? If this player is to be a computer, type the name Computer"
  #black_player = current_game.create_player("black")
  white_player = Player.new("white", "Computer")
  black_player = Player.new("black", "Computer")
  current_game.show_display

  until current_game.assess_endofgame('black', current_game.board) do 
    movement = []

    puts "#{white_player.color} it is now your turn."
    if white_player.name == 'Computer'
      movement = current_game.determine_computer_movement(white_player.color, current_game.board)
    else
      movement = current_game.get_input(white_player)
    end
    p movement
    current_game.play_turn(movement)
    current_game.show_display

    break if current_game.assess_endofgame('white', current_game.board)

    puts "#{black_player.color} it is now your turn."
    if black_player.name == 'Computer'
      movement = current_game.determine_computer_movement(black_player.color, current_game.board)
    else
      movement = current_game.get_input(black_player)
    end
    p movement
    current_game.play_turn(movement)
    current_game.show_display
  end
end
#do the same to test to fix Castling
  #-currently White King can't castle left

#do the same test to fix Checkmate, 
  #-currently White King in checkmate even if a piece can get in the way and disrupt that checkmate

#implement save/load
#style chess properly
#go back through POODR and think about possible ways of refactoring to make it more OOP
#include gif and update README with finished project, features, bugs, reflections