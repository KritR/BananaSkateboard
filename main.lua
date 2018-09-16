local sti = require "sti/sti"

require("src/player")

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
  makePlayer(layer) 

end
function love.update(dt)
  world:update(dt)
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
  map:box2d_draw()

  cam:detach()

  love.graphics.scale(scale)
  love.graphics.translate(-tx,-ty)
  local lookX = player.x
  local lookY = player.y
  cam:lookAt(lookX, lookY)
  cam.x = lookX
  cam.y = lookY
  

end
