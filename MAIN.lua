local arg = ...
local path = "/scripts/modules/"

dofile(path .. "HEADER.lua")
dofile(path .. "INVENTORY.lua")
dofile(path .. "MOVEMENT.lua")
dofile(path .. "ZIGZAG.lua")

zigzag.start(arg, 2)
