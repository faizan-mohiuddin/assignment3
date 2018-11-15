# https://www.primarysite-kidszone.co.uk/kidszone/resources/connect4.htm
# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
# require 'sinatra'		# remove '#' character to run sinatra wen server

# Main class module
module CF_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	TOKEN1 = "O"
	TOKEN2 = "X"

	class Game
		attr_reader :matrix, :player1, :player2, :template, :input, :output, :turn, :turnsleft, :winner, :played, :score, :resulta, :resultb, :guess
		attr_writer :matrix, :player1, :player2, :template, :input, :output, :turn, :turnsleft, :winner, :played, :score, :resulta, :resultb, :guess

		def initialize(input, output)
			@input = input
			@output = output
		end

		def getinput
			txt = @input.gets.chomp
			return txt
		end

		# Any code/methods aimed at passing the RSpect tests should be added below.

		def start												#Outputs the below strings to the display.
			@output.puts("Welcome to Connect 4!")
			@output.puts("Created by: #{created_by}")
			#@output.puts("Game started.")    This has been commented out because the player has not yet chosen to start a game.
			@output.puts("")
			@output.puts("How to play:")
			@output.puts("Player 1: O and Player 2: X")
			@output.puts("Enter the corresponding column number to place a token.")
			@output.puts("If at any point you are stuck or wish to take a break, enter 0 to return to the menu and pause the game.")
		end

		def created_by									#Returns who created the game.
			"Mitchell Edwards and Faizan Mohiuddin"
		end

		def student_id										#Returns the student id.
			51880363
		end

		def displaybegingame									#Output "Begin game." to the display.
			@output.puts("Game on!")
		end

		def displaynewgamecreated							#Output "New game created." to the display.
			@output.puts("New game created!")
		end

		def finish									#Output "Game finished." to the display.
			@output.puts("Game finished.")
		end

		def displaymenu											#Output the Menu to the display.
			@output.puts("Menu: (1)Start | (2)New | (9)Exit")
		end

		def displayplayer1prompt							#Output required player 1 prompt to displauy.
			@output.print("Player 1 enter token (0 returns to menu): ")
		end

		def displayplayer2prompt								#Output required player 2 prompt to displauy.
			@output.print("Player 2 enter token (0 returns to menu): ")
		end

		def displayinvalidinputerror							#Outputs "Invalid input" to the display.
			@output.puts("Invalid input.")
		end

		def displaynomoreroomerror							#Outputs "No more room" to the display.
			@output.puts("No more room.")
		end

		def displaywinner(p)										#Outputs the winner to the display.
			@output.puts("Player #{p} wins.")
		end

		def setplayer1							#Sets player 1 to token 1 (O).
			@player1 = TOKEN1
		end

		def setplayer2							#Sets player 2 to token 2 (X).
			@player2 = TOKEN2
		end

		def getplayer1							#Gets player 1 and sets it to token 1 (0).
			@player1 = TOKEN1
		end

		def getplayer2								#Gets player 2 and sets it to token 2 (X).
			@player2 = TOKEN2
		end

		def clearcolumns					#This function creates the blank matrix required for connect 4.
			@matrix = [["_", "_", "_", "_", "_", "_", "_"],
					   ["_", "_", "_", "_", "_", "_", "_"],
					   ["_", "_", "_", "_", "_", "_", "_"],
					   ["_", "_", "_", "_", "_", "_", "_"],
					   ["_", "_", "_", "_", "_", "_", "_"],
					   ["_", "_", "_", "_", "_", "_", "_"]]
		end

		def getcolumnvalue(a, b)									#Gets the corresponding column value.
			@matrix[a][b]
		end

		def setmatrixcolumnvalue(c, i, v)				#This function finds the corresponding coordinate in the matrix and updates its value to the coressponding value (dependin on the player token value).
			if @matrix[c][i] == ("_")
				@matrix[c][i] = v
			end
		end

		def displayframe									#Displays the empty frame.
			title = " 1 2 3 4 5 6 7 "
			rowdivider = "+-+-+-+-+-+-+-+"

			@output.puts("#{title}")			#Displays column titles.

			@output.puts("#{rowdivider}")	#Displays row divider.

			@matrix.each do |row|
				@output.print("|")
				row.each do |column|
					@output.print("#{column}")
					@output.print("|")
				end
				@output.puts()
			end
			@output.puts("#{rowdivider}")
		end

		def gravityChecker(column, playerToken)
			row = 5
			column -= 1
			occupied = true

			while occupied == true

				if @matrix[row][column] == "_"
					setmatrixcolumnvalue(row, column, playerToken)
					position = [row, column]
					return position
					occupied = false
					checkwinner(row, column, playerToken)
				elsif row >= 1
					row -= 1
				else
					return occupied
					break
				end

			end

		end

		def checkwinner(row, column, playerToken)									#Checks for which player wins.

			winnerFound = false
			index = 1
			count = 1

			#Checks left.
			while winnerFound == false

				leftColumn = column - index
				if leftColumn >= 0 && @matrix[row][leftColumn] == playerToken

					count += 1
					index -= 1
					@output.puts(count)

					if count == 4
						winnerFound = true
					end
				else
					index = 1
					break
				end

			end

			while winnerFound == false

				rightColumn = column + index
				if rightColumn <= 6 && @matrix[row][rightColumn] == playerToken

					count += 1
					index += 1

					if count == 4

						winnerFound = true

					end

				else

					index = 1
					break

				end

			end

			if winnerFound == true
				if playerToken == "O"
					@winner = "1"
				elsif plauerToken == "X"
					@winner = "2"
				end
			end

		end

		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end
