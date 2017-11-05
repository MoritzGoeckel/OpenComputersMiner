local width, pattern = ...
local path = "/scripts/modules/"

dofile(path .. "HEADER.lua")
dofile(path .. "INVENTORY.lua")
dofile(path .. "MOVEMENT.lua")
dofile(path .. "ZIGZAG.lua")
dofile(path .. "PLAIN.lua")
dofile(path .. "SQUARE.lua")

if pattern == 1 then
	zigzag.start(width, 2)
elseif pattern == 2 then
	plain.start(width)
elseif pattern == 3 then
	square.start(width)
else
	print("Error: A problem occured while starting the robot.")
end

