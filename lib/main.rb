require_relative 'current_game'

current_game = CurrentGame.new
#current_game.introduction
current_game.display
#white_player = current_game.get_white_player_name
#black_player = current_game.get_black_player_name

until current_game.checkmate do 
  current_game.play_turn(white_player)
  break if current_game.checkmate
  current_game.play_turn(black_player)
end

#current_game.conclusion

lets write out the pseudocode for what we want to happen every single turn

it is the white player's turn

the CurrentGame asks the white player hey what's your movement with #get_input_array
it then gets #starting_location and an #ending location coordinates from that movement

so the first thing it should do is find out if it needs to get a new input array
we can do this with an until loop 

the until loop should until starting_coordinates_verified and ending_coordinates_verified
CHANGE these method names, coordinates is more readable

