invHelper = {}

function invHelper.getItemName(slot)
	local item = inv.getStackInInternalSlot(slot)
	if item then
		return item.name
	else
		return 'no item found'
	end
end

--checks if the given item is in the inventory and if yes returns the first corresponding slot
function invHelper.containsItem(item)
	for i=1, 16, 1 do
		if item == invHelper.getItemName(i) then
			return i
		end
	end
	return false
end


--returns false if item was not found in the inventory
--returns true if item was found and selected
function invHelper.selectItemInInventory(item)
	local flag = false
	for i=1, 16, 1 do
		if invHelper.getItemName(i) == item then
			r.select(i)
			flag = true
			break
		end
	end
	return flag
end

--returns true if only 3 slots are still emtpy OR if 13 slots contain more than 30 items
function invHelper.checkInventory()
	local c = 0 --item counter
	local e = 0 --empty counter
	local flag = false

	for i=1, 16, 1 do
		if r.count(i) > 30 then
			c = c + 1
		elseif r.count(i) == 0 then
			e = e + 1
		end 
	end
	
	if c >= 13 or e <= 3 then
		flag = true
	end
	return flag
end

function invHelper.transferAllItemsToChest()
	local ignore = {'minecraft:torch', 'quark:custom_chest', 'minecraft:stone', 'minecraft:dirt', 'minecraft:gravel', 'minecraft:cobblestone', 'minecraft:coal'; 'minecraft:diamond_pickaxe'}
	--some items should always stay in the robots inventory
	-- the rest can be transfered to the chest
	for i=1, 16, 1 do
		local flag = false
		for _,v in ipairs(ignore) do
			if invHelper.getItemName(i) == v then
				flag = true
			end
		end

		if flag == false then
			r.select(i)
			r.drop()
		end
	end 
end


--drop items like cobblestone
--keepN specifies if one stack should be kept and how big the stack should be 
	-- example: its enough to keep only 10 cobblestone
function invHelper.dropGargabe(item, keepN)
	local itemStack = false
	if keepN then
		for i=1, 16, 1 do
			--if the stack is not safed yet
			if itemStack == false then
				if invHelper.getItemName(i) == item then
					if r.count(i) >= keepN then
						itemStack = true
					end
				end
			--if the stack is safed, drop the rest
			else
				if invHelper.getItemName(i) == item then
					r.select(i)
					r.drop()
				end
			end
		end
	--drop all 'item' items
	else
		for i=1, 16, 1 do
			if invHelper.getItemName(i) == item then
				r.select(i)
				r.drop()
			end
		end
	end
end

--can be called if the tool brakes for replacing it with a new obe
function invHelper.exchangeTool()
	local tools = {'minecraft:diamond_pickaxe'}
	for _,tool in ipairs(tools) do
		for i=1, 16, 1 do
			if invHelper.getItemName(i) == tool then
				r.select(i)
				--swap the items
				if inv.equip() then
					--stop iterating only when the swap was successful
					return true
				end
			end
		end
	end
end

function invHelper.provideFuel()
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
