local Outro = {}
positive = false
function Outro.load()

end

function Outro.draw()
  if positive then
    love.graphics.setColor(0.3,0.3,0.3, 0.4)
    love.graphics.rectangle("fill", love.graphics.getWidth()/2-75,
          love.graphics.getHeight()/2-45, 150, 90)
    love.graphics.setColor(255,255,255)
    love.graphics.print("YOU WON!!!", love.graphics.getWidth()/2-35, love.graphics.getHeight()/2- 15)
    love.graphics.print("Press space to play again", love.graphics.getWidth()/2-45, love.graphics.getHeight()/2+5)
  else
    love.graphics.setColor(0.3,0.3,0.3, 0.4)
    love.graphics.rectangle("fill", love.graphics.getWidth()/2-75,
          love.graphics.getHeight()/2-45, 150, 90)
    love.graphics.setColor(255,255,255)
    love.graphics.print("YOU LOST!!!", love.graphics.getWidth()/2-35, love.graphics.getHeight()/2- 15)
    love.graphics.print("Press space to try again", love.graphics.getWidth()/2-45, love.graphics.getHeight()/2 + 5)
  end
end

function Outro.update()

end

function Outro.succeeded()
  positive = true
end

function Outro.reset()
  positive = false
end

return Outro
