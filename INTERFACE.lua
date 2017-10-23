print("Start the robot? y/n : ")
local answer = io.read()

if answer == "y" then
	print("robot started..")
	--the absolute path to the starting module must be specified in the dofile() function
	dofile("mnt/005/scripts/modules/MAIN.lua")

--might need a more differentiated functionality between typing "n" and typing not "y"
elseif answer == "n" then
	print("canceled..")

else 
	print("Your input was not valid. Please type 'y' for yes and 'n' for no.")

end