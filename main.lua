local sti = require "sti/sti"

require("src/player")
require("src/Monkey")
require("src/keystone")

local Intro = require "src/Intro"
local Outro = require "src/Outro"


function love.load()
  love.window.setTitle( "Banana Skateboard" )

  music = love.audio.newSource("sfx/crazyfrog.mp3", "static")

  music:setLooping(true)
  music:play()

  startup()

  --These callback function names can be almost any you want:

end

function startup()
  intro = true
  outro = false
  Outro.reset()

  touch_input = {x_initial = 0, y_initial = 0, x_final = 0, y_final = 0}
  player_jump = false

  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()
  Intro.load()
  map = sti("gfx/boom4.lua",{"box2d"})

  map:box2d_init(world)

  local layer = map:addCustomLayer("Sprites")
  local layer2 = map:addCustomLayer("Sprites2")

  makePlayer(layer)
  makeMonkey(layer2)
  makeKeystone()

  background = love.graphics.newImage("gfx/buildings.png")
  backgroundsky = love.graphics.newImage("gfx/sky.png")

  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end
function beginContact(a, b, coll)

end

function endContact(a, b, coll)

end

function preSolve(a, b, coll)

end

function love.keyreleased(key)
  if key == "space" and outro then
    startup()
  end
  if key == "space" and intro then
    Intro.next()
  end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  if(x > love.graphics.getWidth()/2) then
    touch_input.x_initial = x
    touch_input.y_initial = y
  else
    player_jump = true
  end
  if intro then
    Intro.next()
  end
  if outro then
    startup()
  end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
  if(x > love.graphics.getWidth()/2) then
    touch_input.x_final = x
    touch_input.y_final = y
  end
end

function love.touchremoved(id, x, y, dx, dy, pressure)
  touch_input = {x_initial = 0, y_initial = 0, x_final = 0, y_final = 0}
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
  if((a:getUserData() == "player" and b:getUserData() == "monkey") or (a:getUserData() == "monkey" and b:getUserData() == "player")) then
    outro = true
  end
  if((a:getUserData() == "player" and b:getUserData() == "keystone") or (a:getUserData() == "keystone" and b:getUserData() == "player")) then
    Outro.succeeded()
    outro = true
  end
end
function love.update(dt)
  if intro then
    if Intro.update(dt) > 8 then
      intro = false
    end
  elseif outro then
    Outro.update(dt)
  else
    world:update(dt)
    map:update(dt)
  end
end

function clamp(x, min, max)
  return math.max(math.min(x,max), min)
end

function love.draw()
  for i =0, love.graphics.getWidth() / backgroundsky:getWidth() do
    for j =0, love.graphics.getHeight() / backgroundsky:getHeight() do
      love.graphics.draw(backgroundsky, i * backgroundsky:getWidth(), j * backgroundsky:getHeight(), 0, 1, 1, 0, backgroundsky:getHeight() / 2 - 34)
    end
  end



  if intro then
    Intro.draw()
  elseif outro then
    Outro.draw()
  else
    local player = map.layers["Sprites"].player

    x_offset = math.min(-player.x + (love.graphics.getWidth()/2), 0)
    y_offset = math.min(-player.y + (love.graphics.getHeight()/2), 0);

    for i =0, love.graphics.getWidth() / background:getWidth() do
      for j =0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight(), 0, 2, 2, (-x_offset*0.05)+ background:getWidth() / 2, (-y_offset*0.05) + background:getHeight() / 2 )
      end
    end
    local scale = 2
    map:draw(x_offset, y_offset, 1,1 )
    love.graphics.setColor(255, 255, 255)
    -- love.graphics.setColor(255, 0, 0)
    -- map:box2d_draw()

    love.graphics.scale(scale)
  end
end
