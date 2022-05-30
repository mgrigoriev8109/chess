# frozen_string_literal: true

require_relative 'current_game'
require_relative 'player'

system "figlet 'Chess' -f slant -c"
current_game = CurrentGame.new
current_game.populate_gameboard
current_game.display_introduction
white_player = current_game.create_player('white')
black_player = current_game.create_player('black')
current_game.display_instruction
current_game.show_display

until current_game.assess_endofgame('black', current_game.board)
  movement = []

  puts "\n\n- Color #{white_player.color}, #{white_player.name}, it is now your turn."
  if white_player.name.downcase == 'computer'
    movement = current_game.determine_computer_movement(white_player.color, current_game.board)
    puts "The color #{white_player.color} made the move #{white_player.get_algebraic_notation(movement)}.\n\n"
  else
    movement = current_game.get_input(white_player)
    puts "The color #{white_player.color} made the move #{white_player.alg_notation.join('')}.\n\n"
  end

  current_game.play_turn(movement)
  current_game.show_display

  break if current_game.assess_endofgame('white', current_game.board)

  puts "\n\n- Color #{black_player.color}, #{black_player.name}, it is now your turn."
  if black_player.name.downcase == 'computer'
    movement = current_game.determine_computer_movement(black_player.color, current_game.board)
    puts "The color #{black_player.color} made the move #{black_player.get_algebraic_notation(movement)}.\n\n"
  else
    movement = current_game.get_input(black_player)
    puts "The color #{black_player.color} made the move #{black_player.alg_notation.join('')}.\n\n"
  end

  current_game.play_turn(movement)
  current_game.show_display
end
