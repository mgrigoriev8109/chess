# Chess

This will someday be a finished game of Chess, which two players can play on the Command Line Interface. Right now it is simply a skeleton of a README file. 

## Demo

## Features upon completion

* Saves and Load the game
* Player knows when they are in Check
* Player knows when they have won, Checkmate

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