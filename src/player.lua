function makePlayer(layer)
  local player
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
  layer.player.fixture:setUserData("player")

  layer.update = function(self,dt)
    self.player.x = self.player.body:getX()
    self.player.y = self.player.body:getY()
    x,y = self.player.body:getLinearVelocity()
  --here we are going to create some keyboard events
    rightTouch = {x_initial = 0, y_initial = 0, x_final = 0, y_final = 0}
    rightTouch = touch_input or rightTouch

    if love.keyboard.isDown("right") or (rightTouch.x_final - rightTouch.x_initial) > 0 then --press the right arrow key to push the ball to the right
      layer.player.body:applyForce(400, 0)
    end
    if love.keyboard.isDown("left") or (rightTouch.x_final  - rightTouch.x_initial) < 0 then --press the left arrow key to push the ball to the left
      layer.player.body:applyForce(-400, 0)
    end
    if love.keyboard.isDown("up") or player_jump then 
      if math.abs(y) < 0.001 then
        layer.player.body:setLinearVelocity(x, -600)
      end
    end
    if love.keyboard.isDown("r") then
      layer.player.body:setPosition(325,325)
    end
    player_jump = false
  end

  layer.draw = function(self)
    x,y = self.player.body:getLinearVelocity()
    if x >= 0 then
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
    end
    if x < 0 then
      love.graphics.draw(
        self.player.sprite,
        math.floor(self.player.x),
        math.floor(self.player.y),
        0,
        -1,
        1,
        self.player.ox,
        self.player.oy
      )
    end

  end

  map:removeLayer("Player")
end
