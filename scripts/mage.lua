local sheetMageData = { width=64, height=64, numFrames=20, sheetContentWidth=576, sheetContentHeight=256 }

local sheetMage = graphics.newImageSheet( "magekavely.png", sheetMageData )

local sheetMageSequenceData = {
{ name = "kavely",
start = 10,
count = 9,
time = 280,
loopCount = 0
}
}
local animationMage = display.newSprite( sheetMage, sheetMageSequenceData )
animationMage.x = 500
animationMage.y = 250
physics.addBody( animationMage, "dynamic", {friction=0.5, bounce=0.0, density=1.0},
    { box={ halfWidth=15, halfHeight=2, x=0, y=0 }, isSensor=true } )
animationMage.isFixedRotation = true
animationMage.sensorOverlaps = 0

--function moveMage(self, event)
	--if self.x < -50 then
		--self.x = 500
		--else
		--self.x = self.x - self.speed
		--end
--end

--animationMage.enterFrame = moveMage
--Runtime:addEventListener("enterFrame", mage)
