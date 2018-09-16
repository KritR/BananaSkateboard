local sti = require "sti/sti"
Camera = require("hump/camera")  
cam = Camera(0,0, 1)
cam.x = 0
cam.y = 0

function love.load()
  
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  map = sti("gfx/boom2.lua",{"box2d"})

  map:box2d_init(world)
  map:addCustomLayer("Sprite Layer",3)

  local layer = map:addCustomLayer("Sprites", 1)
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
    oy  = sprite:getHeight()/ 1.35
  }
  layer.update = function(self,dt)
    local speed = 96
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      self.player.y = self.player.y - speed * dt
    end
  
  -- Move player down
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
      self.player.y = self.player.y + speed * dt
    end
  
  -- Move player left
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
      self.player.x = self.player.x - speed * dt
    end
  
  -- Move player right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
      self.player.x = self.player.x + speed * dt
    end
   
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
  map:removeLayer("Player")
  
end
function love.update(dt)
  
  map:update(dt)
end

function love.draw()
  local scale = 2
  local screen_width = love.graphics.getWidth() / scale
  local screen_height = love.graphics.getHeight() / scale

  local player = map.layers["Sprites"].player
  local tx = math.floor(player.x - screen_width / 2)
  local ty = math.floor(player.y-screen_height/2)
  cam:attach()

  map:draw(-cam.x + (love.graphics.getWidth()/2), -cam.y + (love.graphics.getHeight()/2), 1,1 )

  cam:detach()

  love.graphics.scale(scale)
  love.graphics.translate(-tx,-ty)
  local lookX = player.x
  local lookY = player.y
  cam:lookAt(lookX, lookY)
  cam.x = lookX
  cam.y = lookY
  

end
