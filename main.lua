display.setStatusBar(display.HiddenStatusBar)

local bg1 = display.newImage("images/canproject.jpg")
bg1:setReferencePoint(display.BottomLeftReferencePoint)
bg1.x = 0
bg1.y = 320
bg1.speed = 1

local bg2 = display.newImage("images/canproject.jpg")
bg2:setReferencePoint(display.BottomLeftReferencePoint)
bg2.x = 480
bg2.y = 320
bg2.speed = 1


function scrollBackground(self, event)
	if self.x < -480 then
		self.x = 480
		else
	self.x = self.x - self.speed
	end
end

bg1.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", bg1)

bg2.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", bg2)
