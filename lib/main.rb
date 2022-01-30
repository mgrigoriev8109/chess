require_relative 'current_game'
require_relative 'player'

current_game = CurrentGame.new
current_game.populate_gameboard
puts "Welcome to a CLI game of Chess!\n\n"
puts "Players move pieces across the Chessboard using the notation A1B1"
puts "In the example A1B1, A1 will represent where your piece is located on this turn."
puts "In the example A1B1, B1 will represent where you want that piece to move.\n\n"
puts "What will be the name of the White Player? If this player is to be a computer, type the name Computer"
white_player = current_game.create_player("white")
puts "\n\nWhat will be the name of the Black Player? If this player is to be a computer, type the name Computer"
black_player = current_game.create_player("black")
current_game.show_display

until current_game.assess_endofgame('black', current_game.board) do 
  movement = []

  puts "\n\nColor #{white_player.color} it is now your turn."
  if white_player.name == 'Computer'
    movement = current_game.determine_computer_movement(white_player.color, current_game.board)
    puts "The color #{white_player.color} made the move #{white_player.get_algebraic_notation(movement)}."
  elsif current_game.get_input(white_player) == 'save'
    puts 'Saving the game'
  else
    movement = white_player.movement
    puts "The color #{white_player.color} made the move #{white_player.alg_notation.join('')}."
  end

  current_game.play_turn(movement)
  current_game.show_display

  break if current_game.assess_endofgame('white', current_game.board)

  puts "\n\nColor #{black_player.color} it is now your turn."
  if black_player.name == 'Computer'
    movement = current_game.determine_computer_movement(black_player.color, current_game.board)
    puts "The color #{black_player.color} made the move #{black_player.get_algebraic_notation(movement)}."
  elsif current_game.get_input(black_player) == 'save'
    puts 'Saving the game'
  else
    movement = black_player.movement
    puts "The color #{black_player.color} made the move #{black_player.alg_notation.join('')}."
  end

  current_game.play_turn(movement)
  current_game.show_display
end

#implement save/load
#style chess properly
#go back through POODR and think about possible ways of refactoring to make it more OOP
#include gif and update README with finished project, features, bugs, reflections