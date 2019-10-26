Bird=Class{}
local GRAVITY=20
function Bird :init()
  self.image=love.graphics.newImage('bird.png')
  self.width=self.image:getWidth()
  self.height=self.image:getHeight()
  self.x=VIRTUAL_WIDTH/2 -100
  self.y=VIRTUAL_HEIGHT/2
  self.dy=0
end

function Bird:update(dt)
  self.dy=self.dy + GRAVITY * dt

  if love.keyboard.wasPressed('space') then
    self.dy= -5
  end

  self.y=self.y+self.dy



end
function Bird:collides(pipes)
   if (self.x+2)+(self.width-4) >= pipes.x and self.x+2 <= PIPE_WIDTH +(pipes.x) then
     if(self.y+2)+(self.height-4)>=pipes.y and self.y+2 <=PIPE_HEIGHT + pipes.y then
       return true
     end
   end
   return false

end

function Bird:render()
  love.graphics.draw(self.image,self.x,self.y)
end
