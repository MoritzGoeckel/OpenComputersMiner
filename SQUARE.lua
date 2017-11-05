square = {}

function square.start(width)

	while(true) do
		r.swingDown()
		r.down()
		r.swingDown()
		r.down()

		local j = 0
		local flag = true
		while(flag) do
			movement.carveForward(width-1, 2)
			j = j + 1
			r.turnLeft()
			movement.carveForward(1, 2)
			r.turnLeft()
			movement.carveForward(width-1, 2)
			j = j + 1

			if j == width then
				r.turnLeft()
				flag = false
			else
				r.turnRight()
				movement.carveForward(1, 2)
				r.turnRight()
			end
		end
		
	end

end