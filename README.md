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

To set a coordinate you should write 'x' coordinate and then 'y' coordinate, click enter between each of those. Range goes from 0 - 2.

Human player is always 'X' token, computer is 'O' token.
