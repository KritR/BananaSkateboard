local sti = require "sti/sti"

require("src/player")
require("src/Monkey")

function love.load()

  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  map = sti("gfx/boom2.lua",{"box2d"})

  map:box2d_init(world)

  local layer = map:addCustomLayer("Sprites")
  local layer2 = map:addCustomLayer("Sprites2")

  makePlayer(layer)
  makeMonkey(layer2)

  background = love.graphics.newImage("gfx/buildings.png")
  love.window.setMode(640,480)
  backgroundsky = love.graphics.newImage("gfx/sky.png")

end
function love.update(dt)
  world:update(dt)
  map:update(dt)
end

function love.draw()
  for i =0, love.graphics.getWidth() / backgroundsky:getWidth() do
    for j =0, love.graphics.getHeight() / backgroundsky:getHeight() do
      love.graphics.draw(backgroundsky, i * backgroundsky:getWidth(), j * backgroundsky:getHeight(), 0, 1, 1, 0, backgroundsky:getHeight() / 2 - 34)
    end
  end

  for i =0, love.graphics.getWidth() / background:getWidth() do
    for j =0, love.graphics.getHeight() / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(), j * background:getHeight(), 0, 2, 2, background:getWidth() / 2, background:getHeight() / 2 )
    end
  end


  local scale = 2
  local player = map.layers["Sprites"].player

  love.graphics.setColor(255, 255, 255) 
  map:draw(-player.x + (love.graphics.getWidth()/2), -player.y + (love.graphics.getHeight()/2), 1,1 )
  -- love.graphics.setColor(255, 0, 0) 
  -- map:box2d_draw()


  love.graphics.scale(scale)



end
