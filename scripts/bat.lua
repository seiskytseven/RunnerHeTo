local sheetBatData = { width=32, height=32, numFrames=16, sheetContentWidth=128, sheetContentHeight=128 }

local sheetBat = graphics.newImageSheet( "lepakko.png", sheetBatData )

local sheetBatSequenceData = {
{ name = "lento",
start = 14,
count = 3,
time = 280,
loopCount = 0
}
}
local animationBat = display.newSprite( sheetBat, sheetBatSequenceData )
animationBat.x = 300
animationBat.y = 250
physics.addBody( animationBat, "dynamic", {friction=0.5, bounce=0.0, density=1.0},
    { box={ halfWidth=15, halfHeight=2, x=0, y=0 }, isSensor=true } )
animationBat.isFixedRotation = true
animationBat.sensorOverlaps = 0
animationBat.speed = 2

animationBat:play()


function moveBat(self, event)
	if self.x < -150 then
		self.x = 400
	else
		self.x = self.x - self.speed
	end
end

animationBat.enterFrame = moveBat
Runtime:addEventListener("enterFrame", animationBat)
