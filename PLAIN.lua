plain = {}

function plain.carveCorridor(n)
	for i=0, n, 1
	do
		movement.carveForward(1,2)
		movement.doTorchStep(10)
	end
end

-- n = length of the corridor
-- dir = shortcut direction (Left or Right)
function plain.carveCorridorLong(n, dir)
	if dir then
		local half = n/2
		--first half
		plain.carveCorridor(half-1)

		if string.lower(dir) == "right" then
			r.turnRight()
			movement.carveForward(1,2)

			plain.checkAndPlaceChest()

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
		--second half
		zigzag.carveCorridor(half-1)
	--if no dir is specified
	else
		plain.carveCorridor(n-1)
	end
	
end

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


function plain.provideFuel()
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
function plain.start(totalWidth)
	local ignore = {'minecraft:stone', 'minecraft:dirt', 'minecraft:gravel'}

	plain.provideFuel()

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
	plain.carveCorridorLong(totalWidth-1)

	while(true) 
	do
		plain.provideFuel()

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
		plain.carveCorridorLong(totalWidth-1)
		r.turnLeft()
		movement.carveForward(1,2)
		r.turnLeft()
		plain.carveCorridorLong(totalWidth-1)
	end
end
