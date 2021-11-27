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

