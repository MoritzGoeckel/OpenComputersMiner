movement = {}

movement.removeBlockSleepSecond = 0.5
movement.torchCounter = 0

function movement.doTorchStep(stepsPerTorch)
	if movement.torchCounter >= stepsPerTorch then
		movement.torchCounter = 0
		-- Todo Place torch

		local itemFound = invHelper.selectItemInInventory("minecraft:torch")
	
		if itemFound == false then
			--Todo Error
			print("Error: No torch in inventory")
			return false
		end

		--Turn
		r.turnLeft()
		r.turnLeft()
		local success = r.place()
		r.turnRight()
		r.turnRight()
		if success == false then
			--Todo Error
			print("Error: Cant find valid place for torch")
			return false
		end
	end
	movement.torchCounter = movement.torchCounter + 1
	return true
end

function movement.checkBridge()
	if r.detectDown() == false then

		local itemFound = invHelper.selectItemInInventory("minecraft:cobblestone")

		if itemFound == false then
			--Todo Error
			print("Error: No stone in inventory")
			return false
		end
		if r.placeDown() == false then
			--Todo error
			print("Error: Cant place block down")
			return false
		end
	end	
	return true
end

function movement.carve(height)
	if r.durability() == 0 or r.durability() == nil then
		--Todo error
		if invHelper.exchangeTool("minecraft:diamond_pickaxe") then
			print("Tool was exchanged...")
		else
			print("Error: No tool")
			while r.durability() == 0 or r.durability() == nil do
				os.sleep(5)
			end
			print("Found a tool now, continuing...")
		end
	end	

	while r.detect() do 
		r.swing()
		os.sleep(movement.removeBlockSleepSecond)
	end
	
	while height >= 2 and r.detectUp() do
		r.swingUp()
		os.sleep(movement.removeBlockSleepSecond)
	end

	-- while height >= 3 and r.detectDown() do
	--	r.swingDown()
	--	os.sleep(movement.removeBlockSleepSecond)
	-- end
	
	return true	
end

function movement.forward(distance)
	if distance == nil then
		distance = 1
	end
	
	for i = 0, distance - 1 do
		movement.checkBridge()
		while r.detect() do
			print("Error: Path blocked, retrying...")
os.sleep(5)
		end
		
		while r.forward() == nil do
			print("Error: Someone ist blocking the way, retrying...")
			os.sleep(5)
		end
	end
	
	return true
end

function movement.checkDurability(tool)
	if r.durability() == 0 or r.durability() == nil then
		if invHelper.exchangeTool(tool) then
			print("Tool was exchanged...")
		else
			--Todo error
			print("Error: No tool")
			while r.durability() == 0 or r.durability() == nil do
				os.sleep(5)
			end
			print("Found a tool now, continuing...")
		end
	end
end

function movement.carveForward(distance, height)
	if distance == nil then
		distance = 1
	end
	
	for i = 0, distance - 1 do
		movement.checkBridge()
		
		movement.checkDurability()
		r.swing()
		while r.forward() == nil do
			movement.checkDurability()
			r.swing()
		end

		while height >= 2 and r.detectUp() do
			movement.checkDurability()
			r.swingUp()
end
	end
	
	return true	
end


function movement.back(distance)
	if distance == nil or distance == null then
		distance = 1
	end
	
	for i = 0, distance - 1 do
		while r.back() == nil do
			print("Error: Someone ist blocking the way, retrying...")
			os.sleep(5)
		end
	end
	
	return true
end

--base function for carving corridors
function movement.carveCorridor(n)
	for i=0, n, 1
	do
		movement.carveForward(1,2)
		movement.doTorchStep(10)
	end
end


-- n = length of the corridor
-- dir = shortcut direction (Left or Right)
function movement.carveCorridorLong(n, dir)
	if dir then
		local half = n/2
		--first half
		movement.carveCorridor(half-1)

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
		movement.carveCorridor(half-1)
	--if no dir is specified
	else
		movement.carveCorridor(n-1)
	end
	
end
