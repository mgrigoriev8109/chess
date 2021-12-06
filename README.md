# Chess

This is the a Command Line Interface game of Chess I created after finishing the Ruby lessons of [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav).

## Demo

## How to play

Chess is played with two Players, who choose either Light or Dark as their color, on a 8x8 64 square Chess Board. The White player moves first. Pieces of the player's respective color are moved across the board based off a piece's Movement Rules. When a piece is able to attack another piece based off of Attacking Rules, it can eliminate that piece and take its place. Once a players King is within range of being attacked, it is in Check. Once a player's King is eliminated, that player loses the game in a Checkmate. 

The pieces are 8 Pawns, 2 Rooks, 2 Bishops, 2 Knights, a Queen and a King.

Each player selects their desired movement by specifying a start location and end location on the Chess board, as long as it is within the legal possible Movement Rules or Attacking Rules of the piece.

Movement Rules:
- Rook: Every move a Rook makes can go vertically and horizontally any number of spaces across the board.
- Bishop: Every move a Bishop makes can go diagonally in any direction any number of spaces across the board. 
- Knight: A knight can move in the shape of an L, moving two spaces forward and one space to the side.
- Queen: A queen can make all the moves of a Rook and a Bishop.
- King: A king can move one space in any direction.
- Pawn: The first move a pawn makes moves forward two spaces, and forward one space every subsequent turn.

Attacking Rules:
- Rook: The same as its Movement Rules.
- Bishop: The same as its Movement Rules.
- Knight: The same as its Movement Rules.
- Queen: The same as its Movement Rules.
- King: The same as its Movement Rules.
- Pawn: A pawn can attack only two spots, forward left and forward right from where it is standing.

## Project Requirements

** Use Git [progressive-stability branching](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)
Master branch will contain only functional code, develop branch will contain code being tested for stability before being merged into master, and topic branches going off of develop that have to pass all tests before being merged into develop. 

** Use [Readme Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
Before writing any code for this project, I'm writing a comprehensive Readme 
**
**

## Possible future additions

## Known Bugs

* There is no working version yet

## Reflections (currently plan/thoughts on future project development)

* Git: This project will be made using a develop branch for incomplete versions of the game, which will be pushed to master once a version is functional. Additional branches will diverge from develop and be merged in one at a time upon completion of feature.

* Testing: RSpec testing will be done to check incoming command methods, incoming query methods, and outgoing command methods. TDD will be adhered to whenever possible. 

* OOP: As per ideas suggested in POODR, objects should be used in the context of the messages they're sending. Most messages should be sent internally via a private interface, and those that are sent between objects should be in the public interface. These public messages should be stable and should reveal resopnsibilities of the classes. **All the messages should ask for what the sender wants**, they should not tell the receiver how to behave. 

* Readability: Comments should be nonexistant, and methods should be readable and easily understood at first glance in plain english - adhering when appropriate to guidelines set by the book Clean Code.

* Further OOP: This is the planning I have so far for messages and their respective classes:
Class:
1) Game
  - I'm giving the command to create a gameboard (Send to self)
  - I'm giving the command to create each of the 8 types of piece classes (Send to self)
  - Can you tell me a query of the current display? (Send to Display Class)
  - Can you tell me a query of what movement you want to make? (Send to Player Class)
2) Player
  - Can you tell me a query of whether or not this piece exists on the GameBoard (Send to Game Class)
  - Can you tell me a query of whether or not this is a possible movement of this Rook on these coordinates? (Send to Rook Class)
  - Can you tell me a query of whether or not this is a possible attack of this Rook on these coordinates? (Send to Rook Class)
  - I'm giving you a command of how to update the gameboard (Send to Game Class)

Based off of these messages, major methods I'm going to be working on during the next three months:
game.create_gameboard
game.create_piece
game.play_turn
player.check_existance_of_piece(piece_type)
player.ask_legality_of_move(piece, coordinates)
player.ask_legality_of_attack(piece, cordinates)

Rough three month timeline:
12/6: This week's goal is to create two rooks on gameboard, and have them pass tests to move around the gameboard.
12/13: Next week will be white Rooks pass tests to successfully attack black Rooks.
12/20: King movement
12/27: King attack
1/3: Check and checkmate. 
1/10: Bishop move 
1/17: Bishop attack, this and every following piece also tests check/checkmate
1/24: Queen move attack
1/31: Knight move 
2/7: Knight attack
2/14: White Pawn move
2/21: White Pawn attack
2/28: Black pawn move
3/4: Black Pawn attack
3/11: Play turn



