local field2D = require "field2D"
local draw2D = require "draw2D"
local win = require "window"
local vec2 = require "vec2"

win:setdim(1200, 800)
math.randomseed(os.time())


local dimx = 28
local dimy = dimx
local field = field2D.new(dimx, dimy)

function field_reset()
	field:set(function() return math.random() end)
	field:diffuse(field, 0.5)
	field:normalize()
end
field_reset()

function draw_agent_boxily(a)
	draw2D.push()
		draw2D.translate(a.pos.x*2, a.pos.y)
		draw2D.rotate(a.direction)
		draw2D.scale(a.scale*9, a.scale*2)
		
		draw2D.color(0.1, 0.9, 0.9,0.4)
		draw2D.line(3, 6, 0.7, 0.1)
		draw2D.color(0.1, 0.2, 0.5,0.7)
		draw2D.line(3, 10, 0.2, 1)
	draw2D.pop()
end

local agents = {}
function reset_agents()
	for i = 1, 3000 do
		agents[i] = {
			pos = vec2(math.random(), math.random()),
			vel = vec2(),
			direction = math.pi * 2 * math.random(),
			scale = 0.09,
		}
	end
end
reset_agents()

function update()
	for i, a in ipairs(agents) do
		local c = field:sample(a.pos.x, a.pos.y)
		--c = c + (math.random() - 0.5)*0.2
		field:update(c, a.pos.x*2, a.pos.y/4)
		a.direction = c * math.pi * 2
		a.vel = vec2.fromPolar(0.1, a.direction)
		a.pos:add(a.vel
		a.pos:mod(1) 
	end
end

function draw()
	draw2D.color(0,0,0)
	field:draw()
	
	for i, a in ipairs(agents) do
		draw_agent_boxily(a)
	end
end	

function key(e, k)
	print(e, k)
	if k == "r" then
		reset_agents()
	end
end
