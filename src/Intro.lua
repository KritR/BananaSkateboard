local Intro = {}
local stringArray = {"Harambe ... You stole my family .....", "GRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
                      "Where is my family .....", "GRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
                      "You messed with the wrong mama jama .....................",
                      "You will have to deal with my minions if you come after me",
                      "That doesn't phase me",
                      "GRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"}

function Intro.load()
  frame = 1
  font = love.graphics.getFont()
  spacePressed = false
  bananaman = love.graphics.newImage("gfx/banana_sprite.png")
  harambe = love.graphics.newImage("gfx/harambe.png")
end

function Intro.next()
  frame = frame + 1
end

function Intro.update(dt)
  return frame
end

function Intro.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", 0,love.graphics.getHeight() - 130,640,130)
  love.graphics.setColor(0,0,0)
  text = love.graphics.newText(font, stringArray[frame])
  love.graphics.draw(text, 20,love.graphics.getHeight() - 100)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bananaman, 0, 10, 0, 4, 4)
  love.graphics.draw(harambe, 250, 0, 0, 0.9, 0.9)
end

function love.keyreleased(key)
  if key == "space" then
    frame = frame + 1
  end
end

return Intro
