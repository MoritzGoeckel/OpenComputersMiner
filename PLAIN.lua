plain = {}

-- Assumption:
-- presupposes the char to be at the left side

-- Goal:
-- places the chest behind the robot
function plain.placeChest()
	local i = invHelper.containsItem('quark:custom_chest')
	if i then
		r.turnLeft()
		r.turnLeft()
		r.select(i)
		r.place()

		invHelper.transferAllItemsToChest()

		r.turnRight()
		r.turnRight()
	end
end


function plain.checkAndPlaceChest()
	if invHelper.checkInventory() then
		plain.placeChest()
	end
end

--width must be odd--
function plain.start(totalWidth)
	local ignore = {'minecraft:stone', 'minecraft:dirt', 'minecraft:gravel'}

	invHelper.provideFuel()

	local midRange = totalWidth/2

	movement.carveForward(1,2)
	r.turnRight()

	--first right part--
	for i=0, midRange-1, 1
	do
		movement.carveForward(1,2)
		movement.doTorchStep(10)
	end

	--go all the way back to the left
	r.turnLeft()
	r.turnLeft()
	movement.carveCorridorLong(totalWidth-1)

	while(true) 
	do
		invHelper.provideFuel()

		--special case cobblestone, some are needed
		invHelper.dropGargabe('minecraft:cobblestone', 10)
		for i,v in ipairs(ignore) do
			invHelper.dropGargabe(v)
		end

		r.turnRight()
		movement.carveForward(1,2)

		--place chests only on the left side
		plain.checkAndPlaceChest()

		r.turnRight()
		movement.carveCorridorLong(totalWidth-1)
		r.turnLeft()
		movement.carveForward(1,2)
		r.turnLeft()
		movement.carveCorridorLong(totalWidth-1)
	end
end
