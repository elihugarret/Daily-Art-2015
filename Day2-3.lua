
--Automata

local field2D = require "field2D"
local draw2D = require "draw2D"
local field = field2D.new(156, 186)
math.randomseed(os.clock())

function draw()
        draw2D.color(0.9,0.2,0.9)
	field:draw()
	
end

local future = 0
local past = 9

function reset()
	field:set(function(x, y)
		if y == past then
			return math.random(3) - math.random(2)
		else
			return 0
		end
	end)
end
reset()

function transition_rule_184(C, E, W)
	if C == 1 and E == 0 then
		C = 0
	elseif C == 0 and W == 1 then
		C = 1
	end
	return C
end

function transition_rule_110(C, E, W)
	if C == 1 and W == 1 and E == 1 then
		C = 0
	elseif C == 0 and E == 1 then
		C = 1
	end
	return C
end

function transition_rule_30(C, E, W)
	if C == 1 and W == 1 then
		C = 0
	elseif C == 0 then
		if W == 1 and E == 1 then
			C = 1
		elseif W == 0 and E == 1 then
			C = 1
		end
	end
	return C
end

function update()
	
	for x = 0, field.width do		 
		 local C = field:get(x, past)		 
		 local E = field:get(x / math.random(2), past+3)
		 local W = field:get(x + math.random(2), past-3)
		 C = transition_rule_30(C, E, W)
		 field:set(C, x, future)                
	end	
	past = future	
	future = (past - 9) % field.height
      
end

function keydown(key)
	reset()
end
