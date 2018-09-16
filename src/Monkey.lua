local Monkey = {}

xPos = 0
yPos = 0
mWidth = 50
mHeight = 50

function Monkey.load(world, x, y)
  xPos = x;
  yPos = y;
  Monkey.body = love.physics.newBody(world, xPos, yPos, "dynamic")
  Monkey.shape = love.physics.newRectangleShape(mWidth, mHeight)
  Monkey.fixture = love.physics.newFixture(Monkey.body, Monkey.shape)
end

function Monkey.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon("fill", Monkey.body:getWorldPoints(Monkey.shape:getPoints()))
end

function Monkey.update()

end

return Monkey
