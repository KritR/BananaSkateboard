function makeKeystone()
  local keystone
  for k, object in pairs(map.objects) do
    if object.name == "Keystone" then
      keystone = object
      break
    end
  end
  local body = love.physics.newBody(world, keystone.x, keystone.y, "static")
  local shape = love.physics.newRectangleShape(0,0,32,32)

  local fixture = love.physics.newFixture(body, shape, 1)
  fixture:setUserData("keystone")

  map:removeLayer("Keystone")
end
