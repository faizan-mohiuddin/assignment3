# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_cf_gen_01"

# Main program
module CF_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	option = 0
	turn = 0
	placed = nil

	@output.puts 'Enter "1" runs game in command-line window or "2" runs it in web browser.'
	game = g.getinput
	if game == "1"
		@output.puts "Command line game"
		system "cls"
	elsif game == "2"
		@output.puts "Web-based game"
	else
		@output.puts "Invalid input! No game selected."
		exit
	end

	if game == "1"

	# Any code added to command line game should be added below.

		g.clearcolumns
		g.setplayer1
		g.setplayer2
		finished = false
		playing = true
		turn = 0

		g.start
		@output.puts("")

		while playing == true

			g.displaymenu
			@output.print("Please enter your choice: ")
			input = ""
			input = g.getinput

			system "cls"

			if input == "1"

				if g.winner == "1" || g.winner == "2"

					g.displaywinner(g.winner)
					@output.puts("")
					@output.puts("If you would like to play again then create a new game by entering 2.")
					@output.puts("")

				elsif turn == 0

					g.displaybegingame
					@output.puts("")

				end

				while finished == false

				if turn == 42

					@output.puts("The match has ended in a draw.")
					@output.puts("")
					@output.puts("If you would like to play again then create a new game by entering 2.")
					@output.puts("")
					finished = true
					break

				end

					g.displayframe
					@output.puts("")

					if turn%2 == 0
						g.displayplayer1prompt
						playerToken = g.getplayer1
					else
						g.displayplayer2prompt
						playerToken = g.getplayer2
					end

					input = ""
					input = g.getinput

					if input == "0"

						system "cls"

						break

					elsif input.to_i >=1 and input.to_i <=7

						occupied = g.gravityChecker(input.to_i, playerToken)
						if occupied == true

							system "cls"

							@output.puts("This column is full please select a different column.")
							@output.puts("")

						elsif g.winner == "1" || g.winner == "2"

							system "cls"

							g.displaywinner(g.winner)
							@output.puts("")
							finished = true

						else

							turn += 1
							@output.print(turn)

							system "cls"

						end

					else

						system "cls"

						@output.puts("")
						g.displayinvalidinputerror
						@output.puts("")

					end

				end

			elsif input == "2"

				g.clearcolumns
				finished = false
				turn = 0
				g.winner = ""

				system "cls"

				g.displaynewgamecreated
				@output.puts("Enter 1 in order to Start the game.")
				@output.puts("")

			elsif input == "9"

				system "cls"

				@output.puts("Exiting game!")
				playing = false

			else

				system "cls"

				g.displayinvalidinputerror

			end

		end
	# Any code added to output the activity messages to the command line window should be added above.

		exit	# Does not allow command-line game to run code below relating to web-based version
	end

end
# End modules

# Sinatra routes

	# Any code added to output the activity messages to a browser should be added below.

	h = CF_Game::Game.new(STDIN, STDOUT)

	$currentPlayer = h.setplayer1
	$waitingPlayer = h.setplayer2
	$turn = 0
	$matrix = h.clearcolumns
	get '/' do

		erb :howtoplay
	end

	get '/play' do

		if h.winner == "1" || h.winner == "2"
			@winner = h.winner
			redirect '/winner'
		end

		@occupied = $occupied
		@turn = $turn

		if $currentPlayer == "O"
			@playerNo = "1's"
		elsif $currentPlayer == "X"
			@playerNo = "2's"
		end

		erb :play

	end

	post '/home' do
		redirect '/'
	end

	post '/new_game' do

		$matrix = h.clearcolumns
		$currentPlayer = h.setplayer1
		$waitingPlayer = h.setplayer2
		h.winner = ""
		$occupied = ""

		redirect '/play'
	end

	post '/move' do

		column = params["move"].to_i
		$occupied = h.gravityChecker(column, $currentPlayer)
		if $occupied == true
			redirect '/play'
	    elsif h.winner == "1" || h.winner == "2"
			$winner = h.winner
			redirect '/winner'
		else

			temp = $currentPlayer
			$currentPlayer = $waitingPlayer
			$waitingPlayer = temp
			$turn += 1

			redirect '/play'

		end

	end

	get '/winner' do
		@winner = $winner
		erb :winner
	end

	# Any code added to output the activity messages to a browser should be added above.

# End program
