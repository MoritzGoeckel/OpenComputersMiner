print("Start the robot? y/n : ")
local startAnswer = io.read()

if startAnswer == "y" then

	local widthAnswer
	while not widthAnswer do
		print("Specify the total width of the corridor.")
		print("Therefore use an odd number.")
		widthAnswer = tonumber(io.read())	
	end

	print("robot started..")
	--the absolute path to the starting module must be specified in the dofile() function
	loadfile("mnt/005/scripts/modules/MAIN.lua")(widthAnswer)

--might need a more differentiated functionality between typing "n" and typing not "y"
elseif startAnswer == "n" then
	print("canceled..")

else 
	print("Your input was not valid. Please type 'y' for yes and 'n' for no.")

end 