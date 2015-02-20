local field2D = require "field2D"
local draw2D = require "draw2D"


local dimx = 156
local dimy = dimx * 3/4 

local field = field2D.new(dimx, dimy)

local field_old = field2D.new(dimx, dimy)
local field_old_old = field2D.new(dimx, dimy)

local min, max = math.min, math.max
local ceil, floor = math.ceil, math.floor

function coin() 
	if math.random() < 0.9 then 
		return 0
	else
		return 1
	end
end

field:set(coin)

function draw()	
        draw2D.color(0,1,1,0.1)
	draw2D.rect(1,2,2,4)
	draw2D.color(0,1,1)
	field:draw()
end

function transition(x, y)
	
	local N   =  field_old:get(x+y  , y+1) == 1 and 1 or 0
	local NE  =  field_old:get(x+1, y+1) == 1 and 1 or 0
	local E   =  field_old:get(x+1, x  ) == 1 and 1 or 0
	local SE  =  field_old:get(x+1, y-1) == 1 and 1 or 0
	local S   =  field_old:get(x+1 , y) == 1 and 1 or 0
	local SW  =  field_old:get(x-1, y-1) == 1 and 1 or 0
	local W   =  field_old:get(x-1, y  ) == 1 and 1 or 0
	local NW  =  field_old:get(x-1, x) == 1 and 1 or 0
	local near = N + E + S + W + NE + NW + SE + SW
	local C = field_old:get(y, x)
	
	if C == 1 then 
		return 0.5
	elseif C == 0.5 then
		return 0
	elseif C == 0 and near == 2 then
		return 1
	else 
		return 0
	end
end

function update(dt) 
     
	field, field_old = field_old, field 
	field:set(transition)
        
end

function keydown(k)
	if k == "c" then
		
		field:clear()
	elseif k == "r" then
		
		field:set(coin)
	
	end
end
