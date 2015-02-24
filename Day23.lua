module(..., package.seeall)
local figura
local figura2
func = function(x, y, z)
  return x * sin(y) + random(.2, .96) + noise(x, y, z) + z *math.sqrt( y%x)* (random(2, 9)) - .73
end
setup = function()
  isom = iso(44, func)
  figura = meshnode(isom)
  fgu:add(figura)
end
update = function(dt)
  figura:set_transform(R(sin(fgu.t%2), 0, 1, 0.2) * S(1 + .02 * sin(.5 * fgu.t / 10)))
  isom = iso(23, func)
  figura:set_mesh(isom)
end
