module(..., package.seeall)
local figura
local figura2
func = function(x, y, z)
  return x * sin(y) + random(.2, .96) + noise(x, y, z) + z *math.sqrt( x)* (random(2, 9)) - .73
end
setup = function()
  isom = iso(math.random(22, 44), func)
  figura = meshnode(isom)
  fgu:add(figura)
end
update = function(dt)
  figura:set_transform(R(sin(fgu.t+2), 0, 1, 0.2) * S(1 + .2 * tan(.5 * fgu.t / 10)))
  isom = iso(math.random(20), func)
  figura:set_mesh(isom)
end
