# Chess

This is the a Command Line Interface game of Chess I created after finishing the Ruby lessons of [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav).

## Demo

## How to play

Chess is played with two Players, who choose either Light or Dark as their color, on a 8x8 64 square Chess Board. These players take turns moving pieces across the board, attempting to place the opposing player in a Checkmate.

The pieces are 8 Pawns, 2 Rooks, 2 Bishops, 2 Knights, a Queen and a King.

Each player selects their desired movement by specifying a start location and end location on the Chess board, as long as it is within the legal possible moves of the piece.

Legal moves of pieces:
- Pawn: The first move a pawn makes moves forward two spaces, and forward one space every subsequent turn.
- Rook: Every move a Rook makes can go vertically and horizontally any number of spaces across the board.
- Bishop: Every move a Bishop makes can go diagonally in any direction any number of spaces across the board. 
- Knight: A knight can move in the shape of an L, moving two spaces forward and one space to the side.
- Queen: A queen can make all the moves of a Rook and a Bishop.
- King: A king can move one space in any direction.

If a piece encounters another piece

## Project Requirements

** Use Git [progressive-stability branching](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)
Master branch will contain only functional code, develop branch will contain code being tested for stability before being merged into master, and topic branches going off of develop that have to pass all tests before being merged into develop. 

** Use [Readme Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
Before writing any code for this project, I'm writing a comprehensive Readme 
**
**

## How to play

## Possible future additions

## Known Bugs

* There is no working version yet

## Reflections (currently plan/thoughts on future project development)

* Git: This project will be made using a develop branch for incomplete versions of the game, which will be pushed to master once a version is functional. Additional branches will diverge from develop and be merged in one at a time upon completion of feature.

* Testing: RSpec testing will be done to check incoming command methods, incoming query methods, and outgoing command methods.

* OOP: Before beginning project I'll finish reading 99 Bottles of OOP, keeping the project in mind and concepts I can implement.

* Privacy: I need to work on using attr_writer less, and keep Classes/their methods more private.

* Readability: Upon writing each new method, take a step back and make sure it's readable in plain english for someone who has never seen the project before. To help with this, before beginning the project I'll read through the rest of the Clean Code book.

* Development Workflow: 

- I'll begin by writing out a clean, understandable main.rb driver script. 

- Then I'll create files for each of the needed classes: Game, Player, Board, Pawn, Rook, Knight, Bishop, Queen, King. 

- Then I'll create a functional display to see a nested array board Board, and I'll set locations for each of the pieces. 

- Then I'll create check and checkmate logic in the Game class. My logic being: if I want to change check/checkmate upon finishing Movement logic, I'll have a lot less to change than changing movement upon finishing check/checkmate. 

- Then I'll create movement logic for each piece. Trying to stay away from recursion, since I leaned on it too heavily in my last project and it made code unreadable. 

- Then I'll create attack logic? 
