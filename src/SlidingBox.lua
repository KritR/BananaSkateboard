local SlidingBox = {}
local velocity  = -50.0
local acceleration = 5.0
local position = 300.0

function SlidingBox.getPosition(time)
  position = (1/2) * acceleration * time * time + velocity * time + position
  velocity = acceleration*time + velocity
  if (position >= love.graphics.getHeight() - 200) then
    position = love.graphics.getHeight() - 200
  end
  return position
end

function SlidingBox.setVelocity(vel)
  velocity = vel
end

return SlidingBox
