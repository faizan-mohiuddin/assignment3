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

		g.start
		@output.puts("")

		ongoingGame = true
		while playing == true

			g.displaymenu
			@output.puts("Please enter your choice:")
			input = g.getinput

			system "cls"

			if input == "1"

				@output.print(@matrix)

				g.displaybegingame
				@output.puts("")

				finished = false
				while finished == false

					g.displayemptyframe
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

						g.gravityChecker(input.to_i, playerToken)

						g.checkwinner

						turn += 1

						system "cls"

					else

						system "cls"

						g.displayinvalidinputerror

					end

				end

			elsif input == "2"

				g.clearcolumns
				turn = 0
				winner = ""

				system "cls"

				g.displaynewgamecreated
				@output.puts("Enter 1 in order to Start the game.")

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



	# Any code added to output the activity messages to a browser should be added above.

# End program
