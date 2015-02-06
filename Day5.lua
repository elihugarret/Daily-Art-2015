local draw2D = require "draw2D"
local field2D = require "field2D"
local gl = require "gl"
local vec2 = require "vec2"


math.randomseed(os.time())


local dimx = 38
local dimy = dimx
local field = field2D(dimx, dimy)
local field_old = field2D(dimx, dimy)

local diffuse_rate = 0.1
local decay_rate = 0.99

function decay(x, y)
	return field:get(x, y) * decay_rate
end


local agents = {}
for i = 1, 8 do
	local a = {
		pos = vec2(),
		vel = vec2(),
		direction = math.pi * 9 * math.random(7),
		scale = 0.1,
	}
	agents[i] = a
end

function reset_agents()
	for i, a in ipairs(agents) do
		a.pos:randomize()
	end
end

reset_agents()

function update()
	field, field_old = field_old, field
	field:diffuse(field_old, diffuse_rate)	
	field:set(decay)
  for i, a in ipairs(agents) do
		  
		local F = vec2.random(0.9)
		
		a.vel:lerp(a.vel - F, 0.9)
		a.vel:limit(0.91)  
		a.pos:add(a.vel)
		a.pos:mod(1)  
		a.direction = a.vel:angle()  
		field:splat(1, a.pos.y, a.pos.x)
	end
end
	
function draw()
	draw2D.color(0.8,0.5,1)
  field:draw()
	for i, a in ipairs(agents) do
    draw2D.push()
			draw2D.translate(a.pos.x, a.pos.y)
			draw2D.rotate(a.direction)
			draw2D.scale(a.scale, a.scale)
		  draw2D.color(0, 0, 0.11,0.4)
			draw2D.rect(3, 1, 0.9, 0.9)
			draw2D.line(8, 4, 0.2, 9)
		draw2D.pop()
	end
end

function mouse(e, b, x, y)
	if e == "down" or e == "drag" then
		agents[1].pos:set(x, y)
	end
end

function keydown(k)
	if k == "a" then
		reset_agents()
	end
end
