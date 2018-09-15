
local time = 0
local SlidingBox = require"SlidingBox"

function love.draw()
    time = time + love.timer.getDelta()
    love.graphics.rectangle("fill", 100, SlidingBox.getPosition(time), 50, 80)


end

function love.mousereleased(x, y, button)
   if button == 1 then
     SlidingBox.setVelocity(-50.0)
     time = 0
   end
end
