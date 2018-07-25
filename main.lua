-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics")
physics.start()

local paint = {
	type = "gradient",
	color1 = { 0, 0.3, 0.4 },
	color2 = { 0, 0.3, 0.2, 0.2},
	direction = "up"
}
	
local background = display.newRect( 240, 160, 700, 320 )
background.anchorX = 0.5
background.anchorY = 0.5
background.fill = paint

local rakennukset = display.newImage("images/city_background_clean.png")
rakennukset.anchorX = 0.1
rakennukset.anchorY = 1.0
rakennukset.x = 0
rakennukset.y = 210
rakennukset:scale( 0.2, 0.2 )
rakennukset.speed = 1
rakennukset.leveys = 1630

local rakennukset2 = display.newImage("images/city_background_clean.png")
rakennukset2.anchorX = 0.1
rakennukset2.anchorY = 1.0
rakennukset2.x = 1638
rakennukset2.y = 210
rakennukset2:scale( 0.2, 0.2 )
rakennukset2.speed = 1
rakennukset2.leveys = 1630



local asphalt = display.newImage("images/asphalt.jpg")
asphalt.anchorX = 0.1
asphalt.anchorY = 0.0
asphalt.x = 0
asphalt.y = 270
asphalt:scale( 0.33, 0.33 )
asphalt.speed = 4
asphalt.leveys = 1348


local asphalt2 = display.newImage("images/asphalt.jpg")
asphalt2.anchorX = 0.1
asphalt2.anchorY = 0.0
asphalt2.x = 1352
asphalt2.y = 270
asphalt2:scale( 0.33, 0.33 )
asphalt2.speed = 4
asphalt2.leveys = 1348




local brick = display.newImage("images/brickwall.jpg")
brick.anchorX = 0.1
brick.anchorY = 0.0
brick.x = 0
brick.y = 210
brick.speed = 4
brick.leveys = 1372


local brick2 = display.newImage("images/brickwall.jpg")
brick2.anchorX = 0.1
brick2.anchorY = 0.0
brick2.x = 1378
brick2.y = 210
brick2.speed = 4
brick2.leveys = 1372


function scrollBackground(self, event)
	if self.x < -self.leveys then
		self.x = self.leveys
	else
		self.x = self.x - self.speed
	end
end

rakennukset.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", rakennukset)


rakennukset2.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", rakennukset2)


asphalt.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", asphalt)


asphalt2.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", asphalt2)


brick.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", brick)

brick2.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", brick2)

local paint2 = {
	type = "gradient",
	color1 = { 0, 0, 0 },
	color2 = { 0.4, 0.4, 0.4, 0.4},
	direction = "up"
}

local paint3 = {
	type = "gradient",
	color1 = { 0, 0, 0 },
	color2 = { 0.4, 0.4, 0.4, 0.4},
	direction = "down"
}


local varjo = display.newRect( 0, 210, 1100, 60 )
varjo.anchorX = 0.1
varjo.anchorY = 0.0
varjo.fill = paint2
varjo.alpha = 0.4


local lattia = display.newRect( 0, 270, 1100, 90 )
lattia.anchorX = 0.1
lattia.anchorY = 0.0
lattia.fill = paint3
lattia.alpha = 0.8
lattia.objType = "ground"
physics.addBody( lattia, "static", {friction=0.5, bounce=0.0 } )

local sheetFumikoData = { width=42, height=56, numFrames=136, sheetContentWidth=714, sheetContentHeight=448 }

local sheetFumiko = graphics.newImageSheet( "Fumiko3.png", sheetFumikoData )

local sheetFumikoSequenceData = {
{ name = "juoksu",
start = 21,
count = 3,
time = 280,
loopCount = 0
},
{ name = "hyppy",
start = 27,
count = 3,
time = 280,
loopCount = 1
},
{ name = "laskeutuminen",
start = 30,
count = 2,
time = 200,
loopCount = 1
}


}

local animationFumiko = display.newSprite( sheetFumiko, sheetFumikoSequenceData )
animationFumiko.anchorX = 0.0
animationFumiko.anchorY = 1.0
animationFumiko.x = 40
animationFumiko.y = 250
physics.addBody( animationFumiko, "dynamic", {friction=0.5, bounce=0.0, density=1.0},
    { box={ halfWidth=15, halfHeight=2, x=0, y=0 }, isSensor=true } )
animationFumiko.isFixedRotation = true
animationFumiko.sensorOverlaps = 0
	
animationFumiko:play()

local function touchAction( event )
 
    if ( event.phase == "began" and animationFumiko.sensorOverlaps > 0 ) then
        -- Jump procedure here
        local vx, vy = animationFumiko:getLinearVelocity()
        animationFumiko:setLinearVelocity( vx, 0 )
        animationFumiko:applyLinearImpulse( nil, -18, animationFumiko.x, animationFumiko.y )
		
    end
end

Runtime:addEventListener( "touch", touchAction )


local function sensorCollide( self, event )
 
    -- Confirm that the colliding elements are the foot sensor and a ground object
    if ( event.selfElement == 2 and event.other.objType == "ground" ) then
 
        -- Foot sensor has entered (overlapped) a ground object
        if ( event.phase == "began" ) then
			animationFumiko:setSequence( "laskeutuminen" )
			animationFumiko:play()
            self.sensorOverlaps = self.sensorOverlaps + 1
        -- Foot sensor has exited a ground object
        elseif ( event.phase == "ended" ) then
			animationFumiko:setSequence( "hyppy" )
			animationFumiko:play()
            self.sensorOverlaps = self.sensorOverlaps - 1
        end
    end
end
-- Associate collision handler function with character
animationFumiko.collision = sensorCollide
animationFumiko:addEventListener( "collision" )

local function spriteListener( event )
 
    local thisSprite = event.target  -- "event.target" references the sprite

    if ( event.phase == "ended" and event.target.sequence == "laskeutuminen") then 
        animationFumiko:setSequence( "juoksu" )  -- switch to "fastRun" sequence
        animationFumiko:play()  -- play the new sequence
    end
end


animationFumiko:addEventListener( "sprite", spriteListener )
