function makeMonkey(layer)
  local monkey
  for k, object in pairs(map.objects) do
    if object.name == "Monkey" then
      monkey = object
      break
    end
  end
  local sprite = love.graphics.newImage("gfx/monkey.png")
  layer.monkey = {
    sprite = sprite,
    x   = monkey.x,
    y   = monkey.y,
    ox  = sprite:getWidth()/2,
    oy  = sprite:getHeight()/ 1.35,
    body = love.physics.newBody(world, monkey.x, monkey.y, "dynamic"),
    shape = love.physics.newRectangleShape(0,0,32,32)
  }
  layer.monkey.fixture = love.physics.newFixture(layer.monkey.body, layer.monkey.shape, 1)

  layer.update = function(self,dt)
    self.monkey.x = self.monkey.body:getX()
    self.monkey.y = self.monkey.body:getY()
  end

  layer.draw = function(self)
    love.graphics.draw(
      self.monkey.sprite,
      math.floor(self.monkey.x),
      math.floor(self.monkey.y),
      0,
      1,
      1,
      self.monkey.ox,
      self.monkey.oy
    )

    love.graphics.setPointSize(5)
    love.graphics.points(math.floor(self.monkey.x),math.floor(self.monkey.y))
  end

  map:removeLayer("Enemy")
end
