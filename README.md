# Chess

This is the a Command Line Interface game of Chess I created after finishing the Ruby lessons of [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav).

You can play the game online using [replit](https://replit.com/@mgrig92/chess#.replit)

## Demo

<img src='chess_sample.gif' alt='computer_check'>

## Features

- Play against other humans, or computer
- Aggressive AI. Computer will attempt to put you into checkmate or check if possible, and if not will attempt to always attack you.
- Ability to save and load the game
- Code driven heavily by TDD, with nearly complete test coverage. 

## Understanding code coordinates

When looking through the code, note that methods send messages regarding piece locations using the notation [row, column]. This is the same notation used when accessing a nested array. The Chessboard in this project is a nested array. So when a method returns the coordinates `[1,2]`, it is talking about row 1, column 2 of the Chessboard, or in other words `board[1][2]`.

## Known Bugs

* Rubocop uncompliant. I did not realise until the end of the project that Rubocop had been turned off. If I choose this project as a portfolio piece, I will revisit the this oversight and fix all Rubocop infractions. 

## Reflections

This project was an amazing experience, and allowed me to get a feel for both OOP basics and proper testing. I think planning to have the project be message-oriented, going off the Sandi Metz's POODR saved me a lot of frustration. Staying true to testing every method that needed tests did the same. There were times towards the end of the project where I encountered unexpected bugs, which were quickly revealed as an error I could have avoided if I hadn't missed testing a method.

That being said, there is a lot of room for improvement. As I neared the end of the project I saw a way I could have made **all** of my movement methods more readable. I saw ways I could have performed much better testing. I saw the importance of end to end testing, and integration testing. I realised how little of an understanding I have of OOP. 

I've learned too much from this project to put into words, and I'm excited to use future projects to cover the gaps in my knowledge that Chess has exposed. 



