local sti = require "sti/sti"
function love.load()
  
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  map = sti("gfx/boom.lua",{"box2d"})

  map:box2d_init(world)
  map:addCustomLayer("Sprite Layer",3)

  
end
 
 
function love.update(dt)
  map:update(dt)
end
 
function love.draw()
  love.graphics.setColor(255,255,255)
  map:draw()
  love.graphics.setColor(255,0,0)
  map:box2d_draw()
end
