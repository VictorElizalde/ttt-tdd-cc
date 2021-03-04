# Running the environment
The ruby version we are going to be using is `2.6.3`
First we need to run bundle install in your working directory:
```
$ bundle install
```
To run all tests:
```
$ rspec
```
If you want to run a certain test file:
```
$ rspec spec/file_spec.rb
```

To run and play the game we run the file that connects all the libraries:
```
$ ruby lib/play_game.rb
```

At the beginning of the game it will ask you to choose a input type, the options are terminal or browser
```
Select input
1: terminal input
2: web browser input
```
If you choose option 1 it will work as expected on terminal, to set a coordinate you should write 'x' coordinate and then 'y' coordinate, click enter between each of those. Range goes from 0 to 2.

However if you choose option 2, you should open your browser on this url: http://localhost:5000/ttt (You need to have the cob_spec_server running) see this link to know how to start it: https://github.com/VictorElizalde/cob_spec_server

Once in the url you will play as expected but instead of giving the input with coordinates you will click on the spaces where there are no tokens. The turns work as normal, first the human and then the computer will automatically play its move and the url will refresh with the new board on each move.

Human player is always 'X' token, computer is 'O' token.
