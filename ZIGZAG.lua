zigzag = {}

function zigzag.carveCorridor(n)
	for i=0, n, 1
	do
		movement.carveForward(1,2)
		movement.doTorchStep(10)
	end
end

function zigzag.back180(n)
	r.turnRight()
	r.turnRight()
	zigzag.carveCorridor(n)
	r.turnRight()
	r.turnRight()
end

-- n = length of the corridor
-- dir = shortcut direction (Left or Right)
function zigzag.carveCorridorLong(n, dir)
	local half = n/2
	zigzag.carveCorridor(half-1)
	if string.lower(dir) == "right" then
		r.turnRight()
		movement.carveForward(1,2)

		zigzag.checkAndPlaceChest()

		movement.doTorchStep(10)
		movement.carveForward(1,2)
		movement.doTorchStep(10)
		movement.carve(2)

		--go back
		zigzag.back180(1)

		r.turnLeft()
	elseif string.lower(dir) == "left" then
		r.turnLeft()
		movement.carveForward(1,2)

		zigzag.checkAndPlaceChest()

		movement.doTorchStep(10)
		movement.carveForward(1,2)
		movement.doTorchStep(10)
		movement.carve(2)

		--go back
		zigzag.back180(1)

		r.turnRight()
	end
	zigzag.carveCorridor(half-1)
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


function zigzag.provideFuel()
	if(g.count() < 10) then
		local slot = invHelper.containsItem('minecraft:coal')
		if slot then
			r.select(slot)
			g.insert(64)
		else
			return 'required resource not found'
		end
	end
end

--width must be odd--
function zigzag.start(totalWidth, sideWidth)
	local ignore = {'minecraft:stone', 'minecraft:dirt', 'minecraft:gravel'}

	zigzag.provideFuel()

	--flag specifies if the robot SHOULD go to the right next
	local midRange = totalWidth/2

	zigzag.carveCorridor(4)
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
		zigzag.provideFuel()

		--special case cobblestone, some are needed
		invHelper.dropGargabe('minecraft:cobblestone', 10)
		for i,v in ipairs(ignore) do
			invHelper.dropGargabe(v)
		end

		r.turnLeft()
		zigzag.carveCorridor(sideWidth)
		r.turnLeft()
		zigzag.carveCorridorLong(totalWidth, "right")
		r.turnRight()
		zigzag.carveCorridor(sideWidth)
		r.turnRight()
		zigzag.carveCorridorLong(totalWidth, "left")
	end
end
