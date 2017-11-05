print("Start the robot? y/n : ")
local startAnswer = io.read()

if startAnswer == "y" then

	local patternAnswer
	--requires a valid input of pattern-selection
	while not patternAnswer do
		print("Select a pattern:")
		print("1. zigzag")
		print("2. plain")
		print("3. square")
		patternAnswer = tonumber(io.read())
		if patternAnswer ~= 1 and patternAnswer ~= 2 and patternAnswer ~= 3 then
			patternAnswer = nil
		end 
	end

	local widthAnswer
	--requires a valid input of width-selection
	while not widthAnswer do

		if patternAnswer == 1 then

			while not widthAnswer do
				print("Specify the total width of the corridor.")
				print("Therefore use an odd number.")
				widthAnswer = tonumber(io.read())	
			end

		elseif patternAnswer == 2 then

			while not widthAnswer do
				print("Specify the total width of the corridor.")
				print("Therefore use an odd number.")
				widthAnswer = tonumber(io.read())	
			end

		elseif patternAnswer == 3 then

			while not widthAnswer do
				print("Specify the total width of the corridor.")
				print("Therefore use an even number.")
				widthAnswer = tonumber(io.read())	
			end

		else

			widthAnswer = nil

		end
	end

	print("robot started..")
	--the absolute path to the starting module must be specified in the dofile() function
	loadfile("/scripts/modules/MAIN.lua")(widthAnswer, patternAnswer)

--might need a more differentiated functionality between typing "n" and typing not "y"
elseif startAnswer == "n" then
	print("canceled..")

else 
	print("Your input was not valid. Please type 'y' for yes and 'n' for no.")

end 