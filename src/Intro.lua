local Intro = {}
local stringArray = {"Harambe ... You stole my family .....", "GRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
                      "Where is my family .....", "GRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
                      "You messed with the wrong mama jama ....................."}

function Intro.load()
  frame = 1
  font = love.graphics.getFont()
  spacePressed = false
end

function Intro.update(dt)
  return frame
end

function Intro.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", 0,350,640,130)
  love.graphics.setColor(0,0,0)
  text = love.graphics.newText(font, stringArray[frame])
  love.graphics.draw(text, 20,400)
  love.graphics.setColor(255,255,255)
end

function love.keyreleased(key)
  if key == "space" then
    frame = frame + 1
  end
end

return Intro
