zigzag = {}

function zigzag.back180(n)
	r.turnRight()
	r.turnRight()
	movement.carveCorridor(n)
	r.turnRight()
	r.turnRight()
end

-- Assumption:
-- presupposes the char to be at the first
-- position of the shortcut corridor

-- Goal:
-- places the on the left of the 
-- first position of the shortcut corridor
function zigzag.placeChest()
	local i = invHelper.containsItem('quark:custom_chest')
	if i then
		r.turnLeft()
		movement.carveForward(1,2)
		r.turnRight()
		r.turnRight()
		movement.carveForward(1,2)
		r.turnLeft()
		r.turnLeft()
		r.select(i)
		r.place()

		invHelper.transferAllItemsToChest()

		r.turnRight()
	end
end


function zigzag.checkAndPlaceChest()
	if invHelper.checkInventory() then
		zigzag.placeChest()
	end
end

--width must be odd--
function zigzag.start(totalWidth, sideWidth)
	local ignore = {'minecraft:stone', 'minecraft:dirt', 'minecraft:gravel'}

	invHelper.provideFuel()

	--flag specifies if the robot SHOULD go to the right next
	local midRange = totalWidth/2

	movement.carveCorridor(4)
	--go back
	zigzag.back180(2)

	r.turnRight()

	--first right part--
	for i=0, midRange-1, 1
	do
		movement.carveForward(1,2)
		movement.doTorchStep(10)
	end

	while(true) 
	do
		invHelper.provideFuel()

		--special case cobblestone, some are needed
		invHelper.dropGargabe('minecraft:cobblestone', 10)
		for i,v in ipairs(ignore) do
			invHelper.dropGargabe(v)
		end

		r.turnLeft()
		movement.carveCorridor(sideWidth)
		r.turnLeft()
		movement.carveCorridorLong(totalWidth, "right")
		r.turnRight()
		movement.carveCorridor(sideWidth)
		r.turnRight()
		movement.carveCorridorLong(totalWidth, "left")
	end
end
