function makeMonkey(layer)
--[[  local player
  for k, object in pairs(map.objects) do
    if object.name == "Player" then
      player = object
      break
    end
  end
  local sprite = love.graphics.newImage("gfx/banana_sprite.png")
  layer.player = {
    sprite = sprite,
    x   = player.x,
    y   = player.y,
    ox  = sprite:getWidth()/2,
    oy  = sprite:getHeight()/ 1.35,
    body = love.physics.newBody(world, player.x, player.y, "dynamic"),
    shape = love.physics.newRectangleShape(0,0,32,64)
  }
  layer.player.fixture = love.physics.newFixture(layer.player.body, layer.player.shape, 1)
  layer.player.fixture:setRestitution(0.0)

  layer.update = function(self,dt)
    self.player.x = self.player.body:getX()
    self.player.y = self.player.body:getY()
  end

  layer.draw = function(self)
    love.graphics.draw(
      self.player.sprite,
      math.floor(self.player.x),
      math.floor(self.player.y),
      0,
      1,
      1,
      self.player.ox,
      self.player.oy
    )

    love.graphics.setPointSize(5)
    love.graphics.points(math.floor(self.player.x),math.floor(self.player.y))
  end

  map:removeLayer("Player")]]--
end
