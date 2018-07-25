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
