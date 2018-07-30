-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local paint
local paint2
local paint3
local background
local buildings
local buildings2
local asphalt
local asphalt2
local brickwall
local brickwall2
local brickShadow
local ground
local fumiko
local bat
-- local mage
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	
	local physics = require("physics")
	physics.start()
	-- physics.setGravity( 0, 1.5 )
		
	local paint = {
		type = "gradient",
		color1 = { 0, 0.3, 0.4 },
		color2 = { 0, 0.3, 0.2, 0.2},
		direction = "up"
	}
		
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
		
	background = display.newRect( sceneGroup, 240, 160, 700, 320 )
	background.anchorX = 0.5
	background.anchorY = 0.5
	background.fill = paint

	buildings = display.newImage( sceneGroup, "images/city_background_clean.png")
	buildings.anchorX = 0.1
	buildings.anchorY = 1.0
	buildings.x = 0
	buildings.y = 210
	buildings:scale( 0.2, 0.2 )
	buildings.speed = 1
	buildings.leveys = 1630

	buildings2 = display.newImage( sceneGroup, "images/city_background_clean.png")
	buildings2.anchorX = 0.1
	buildings2.anchorY = 1.0
	buildings2.x = 1638
	buildings2.y = 210
	buildings2:scale( 0.2, 0.2 )
	buildings2.speed = 1
	buildings2.leveys = 1630

	asphalt = display.newImage( sceneGroup, "images/asphalt.jpg")
	asphalt.anchorX = 0.1
	asphalt.anchorY = 0.0
	asphalt.x = 0
	asphalt.y = 270
	asphalt:scale( 0.33, 0.33 )
	asphalt.speed = 3
	asphalt.leveys = 1348

	asphalt2 = display.newImage( sceneGroup, "images/asphalt.jpg")
	asphalt2.anchorX = 0.1
	asphalt2.anchorY = 0.0
	asphalt2.x = 1352
	asphalt2.y = 270
	asphalt2:scale( 0.33, 0.33 )
	asphalt2.speed = 3
	asphalt2.leveys = 1348

	brickwall = display.newImage( sceneGroup, "images/Brickwall.jpg")
	brickwall.anchorX = 0.1
	brickwall.anchorY = 0.0
	brickwall.x = 0
	brickwall.y = 210
	brickwall.speed = 3
	brickwall.leveys = 1372

	brickwall2 = display.newImage( sceneGroup, "images/Brickwall.jpg")
	brickwall2.anchorX = 0.1
	brickwall2.anchorY = 0.0
	brickwall2.x = 1378
	brickwall2.y = 210
	brickwall2.speed = 3
	brickwall2.leveys = 1372

	brickShadow = display.newRect( sceneGroup, 0, 210, 1100, 60 )
	brickShadow.anchorX = 0.1
	brickShadow.anchorY = 0.0
	brickShadow.fill = paint2
	brickShadow.alpha = 0.4

	ground = display.newRect( sceneGroup, 0, 270, 1100, 90 )
	ground.anchorX = 0.1
	ground.anchorY = 0.0
	ground.fill = paint3
	ground.alpha = 0.8
	ground.objType = "ground"
	physics.addBody( ground, "static", {friction=0.5, bounce=0.0 } )
	
	
		
	local sheetFumikoData = { width=42, height=56, numFrames=136, sheetContentWidth=714, sheetContentHeight=448 }
	local sheetFumiko = graphics.newImageSheet( "scenes/images/Fumiko3.png", sheetFumikoData )

	local sheetFumikoSequenceData = {
	{ name = "istuminen",
	frames = { 33,50 },
	time = 2000,
	loopCount = 0
	},
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
	
	
	local fumikoFrameIndex = 34
	 
	local fumikoOutline = graphics.newOutline( 2, sheetFumiko, fumikoFrameIndex )
	
	
	
	fumiko = display.newSprite( sheetFumiko, sheetFumikoSequenceData )
	fumiko.anchorX = 0.5
	fumiko.anchorY = 1.0
	physics.addBody( fumiko, "dynamic", { outline=fumikoOutline, friction=0.5, bounce=0.0, density=1.0},
		{ box={ halfWidth=10, halfHeight=5, x=0, y=0 }, isSensor=true } )
	fumiko.isFixedRotation = true
	sceneGroup:insert( fumiko )
	
	local sheetBatData = { width=32, height=32, numFrames=16, sheetContentWidth=128, sheetContentHeight=128 }

	local sheetBat = graphics.newImageSheet( "scenes/images/lepakko.png", sheetBatData )
	
	
	local batFrameIndex = 15
	 
	local batOutline = graphics.newOutline( 2, sheetBat, batFrameIndex )
	
	
	local sheetBatSequenceData = {
	{ name = "lento",
	start = 14,
	count = 3,
	time = 280,
	loopCount = 0
	}
	}
	bat = display.newSprite( sheetBat, sheetBatSequenceData )
	bat.isFixedRotation = true
	bat.speed = 4
	physics.addBody( bat, "static", { outline=batOutline, friction=0.5, bounce=0.0, density=1.0 } )
	bat.objType = "enemy"
	sceneGroup:insert( bat )
	
			
	function scrollBackground(self, event)
		
		if composer.getSceneName( "current" ) == "scenes.game" then
			if self.x < -self.leveys then
				self.x = self.leveys
			else
				self.x = self.x - self.speed
			end
		else
		
		end
	end
			
	buildings.enterFrame = scrollBackground

	buildings2.enterFrame = scrollBackground

	asphalt.enterFrame = scrollBackground

	asphalt2.enterFrame = scrollBackground

	brickwall.enterFrame = scrollBackground

	brickwall2.enterFrame = scrollBackground

	function moveBat(self, event)
		if self.x < -150 then
			self.x = 800
			self.y = math.random(180,250)
		else
			self.x = self.x - self.speed
		end
	end

	bat.enterFrame = moveBat
	

	function touchAction( event )
			print("nappi")
			print(fumiko.sensorOverlaps)
			print(event.phase)
		if ( event.phase == "began" and fumiko.sensorOverlaps == 1 ) then
		
			-- Jump procedure here
			local vx, vy = fumiko:getLinearVelocity()
			fumiko:setLinearVelocity( vx, 0 )
			fumiko:applyLinearImpulse( nil, -12, fumiko.x, fumiko.y )
			
		end
	end



	function sensorCollide( self, event )
		if (event.phase == "began" ) then
		end
		-- Confirm that the colliding elements are the foot sensor and a ground object
		if ( event.selfElement == 6 and event.other.objType == "ground" ) then
		
			-- Foot sensor has entered (overlapped) a ground object
			if ( event.phase == "began" ) then
				self:setSequence( "laskeutuminen" )
				self:play()
				self.sensorOverlaps = 1
			-- Foot sensor has exited a ground object
			elseif ( event.phase == "ended" ) then
				self:setSequence( "hyppy" )
				self:play()
				self.sensorOverlaps = 0
			end
		elseif ( event.other.objType == "enemy" ) and ( event.phase == "began" ) then
			composer.gotoScene( "scenes.restart", "fade", 800 )
		end
	end
	-- Associate collision handler function with character
	fumiko.collision = sensorCollide

	function spriteListener( event )
	 
		local thisSprite = event.target  -- "event.target" references the sprite

		if ( event.phase == "ended" and event.target.sequence == "laskeutuminen") then 
			fumiko:setSequence( "juoksu" )  -- switch to "fastRun" sequence
			fumiko:play()  -- play the new sequence
		end
	end
	
	


end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		
		-- physics.setDrawMode( "debug" )
		physics.start()
		fumiko:setSequence( "juoksu" )
		fumiko:play()
		fumiko.x = 10
		fumiko.y = 270
		fumiko:setLinearVelocity( 0, 0 )
		fumiko.sensorOverlaps = 1
		bat:setSequence( "lento" )
		bat:play()
		bat.x = 800
		bat.y = math.random(180,250)
		
		
			
		Runtime:addEventListener("enterFrame", buildings)
		Runtime:addEventListener("enterFrame", buildings2)
		Runtime:addEventListener("enterFrame", asphalt)
		Runtime:addEventListener("enterFrame", asphalt2)
		Runtime:addEventListener("enterFrame", brickwall)
		Runtime:addEventListener("enterFrame", brickwall2)

			
		Runtime:addEventListener( "touch", touchAction )
		fumiko:addEventListener( "collision" )
		fumiko:addEventListener( "sprite", spriteListener )
		Runtime:addEventListener("enterFrame", bat)
		
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		
				
		
		
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
		physics.pause()
		fumiko:pause()
		bat:pause()
		
		
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
		
		
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene