-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--=Alustetaan käytettävät muuttujat
local paint
local paint2
local paint3
local paint4
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
local mage
local gameMusic
local jumpSound
local gameMusicChannel
local gameSoundEffectChannel
local scoreText
local score
local options
local scoreTimer
local speedTimer
local scoreboard
local baseSpeed

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	physics.start()
	physics.setGravity( 0, 20 )
	
	gameMusic = audio.loadStream( "scenes/musics/Emotive-Loop.mp3" )
	jumpSound = audio.loadSound( "scenes/sounds/jump2.mp3" )
	
	--=Käytettävät värit
	paint = {
		type = "gradient",
		color1 = { 0, 0.3, 0.4 },
		color2 = { 0, 0.3, 0.2, 0.2},
		direction = "up"
	}
		
	paint2 = {
		type = "gradient",
		color1 = { 0, 0, 0 },
		color2 = { 0.4, 0.4, 0.4, 0.4},
		direction = "up"
	}

	paint3 = {
		type = "gradient",
		color1 = { 0, 0, 0 },
		color2 = { 0.4, 0.4, 0.4, 0.4},
		direction = "down"
	}
	
	paint4 = {
	type = "gradient",
	color1 = { 0.7, 0.7, 0.7 },
	color2 = { 0.5, 0.5, 0.5, 0.2},
	direction = "down"
	}
		
		
	--=Taustan asetteleminen
	background = display.newRect( sceneGroup, 240, 160, 700, 320 )
	background.anchorX, background.anchorY = 0.5, 0.5
	background.fill = paint

	buildings = display.newImage( sceneGroup, "images/city_background_clean.png")
	buildings.anchorX, buildings.anchorY = 0.1, 1.0
	buildings.x, buildings.y = 0, 210
	buildings:scale( 0.2, 0.2 )
	buildings.speed = 1
	buildings.leveys = 1630

	buildings2 = display.newImage( sceneGroup, "images/city_background_clean.png")
	buildings2.anchorX, buildings2.anchorY = 0.1, 1.0
	buildings2.x, buildings2.y = 1638, 210
	buildings2:scale( 0.2, 0.2 )
	buildings2.speed = 1
	buildings2.leveys = 1630

	asphalt = display.newImage( sceneGroup, "images/asphalt.jpg")
	asphalt.anchorX, asphalt.anchorY = 0.1, 0.0
	asphalt.x, asphalt.y = 0, 270
	asphalt:scale( 0.33, 0.33 )
	asphalt.speed = 3
	asphalt.leveys = 1348

	asphalt2 = display.newImage( sceneGroup, "images/asphalt.jpg")
	asphalt2.anchorX, asphalt2.anchorY = 0.1, 0.0
	asphalt2.x, asphalt2.y = 1352, 270
	asphalt2:scale( 0.33, 0.33 )
	asphalt2.speed = 3
	asphalt2.leveys = 1348

	brickwall = display.newImage( sceneGroup, "images/Brickwall.jpg")
	brickwall.anchorX, brickwall.anchorY = 0.1, 0.0
	brickwall.x, brickwall.y = 0, 210
	brickwall.speed = 3
	brickwall.leveys = 1372

	brickwall2 = display.newImage( sceneGroup, "images/Brickwall.jpg")
	brickwall2.anchorX, brickwall2.anchorY = 0.1, 0.0
	brickwall2.x, brickwall2.y = 1378, 210
	brickwall2.speed = 3
	brickwall2.leveys = 1372

	brickShadow = display.newRect( sceneGroup, 0, 210, 1100, 60 )
	brickShadow.anchorX, brickShadow.anchorY = 0.1, 0.0
	brickShadow.fill = paint2
	brickShadow.alpha = 0.4

	ground = display.newRect( sceneGroup, 0, 270, 1100, 90 )
	ground.anchorX, ground.anchorY = 0.1, 0.0
	ground.fill = paint3
	ground.alpha = 0.8
	ground.objType = "ground"
	physics.addBody( ground, "static", {friction=0.5, bounce=0.0 } )
	
		
	--=Pistenäytön asetteleminen
	scoreboard = display.newRoundedRect( sceneGroup, 320, 50, 200, 40, 10 )
	scoreboard.anchorX, scoreboard.anchorY = 0.0, 0.5
	scoreboard.fill = paint4
	
	scoreText = display.newText( sceneGroup, "Score: 0", 0, 0, native.systemFont, 30)
	scoreText.anchorX, scoreText.anchorY = 0.0, 0.5
	scoreText.x, scoreText.y = 330, 50
	scoreText:setFillColor( 0.05, 0.1, 0.2)
	
	
	--=Pelattavan Fumiko-hahmon asetteleminen	
	
	--Fumiko-hahmon eri kuvat ovat sheetFumiko-muuttujassa
	local sheetFumikoData = { width=42, height=56, numFrames=136, sheetContentWidth=714, sheetContentHeight=448 }
	local sheetFumiko = graphics.newImageSheet( "scenes/images/Fumiko3.png", sheetFumikoData )

	--Fumiko hahmon animaatiot asetetaan sheetFumikoSequenceData-muuttujaan
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
	
	--Fumiko-hahmon fysiikat (mukaan lukien osumaboksit) tulevat 34. Fumiko-kuvaan perustuen
	local fumikoFrameIndex = 34
	local fumikoOutline = graphics.newOutline( 2, sheetFumiko, fumikoFrameIndex )
	
	--Itse Fumiko-hahmon luominen display-objektiksi
	fumiko = display.newSprite( sheetFumiko, sheetFumikoSequenceData )
	fumiko.anchorX = 0.5
	fumiko.anchorY = 1.0
	physics.addBody( fumiko, "dynamic", { outline=fumikoOutline, friction=0.5, bounce=0.0, density=1.0},
		{ box={ halfWidth=10, halfHeight=5, x=0, y=0 }, isSensor=true } )
	fumiko.isFixedRotation = true
	sceneGroup:insert( fumiko )
	
	
	--=Bat-hahmon asetteleminen	
	
	--Bat-hahmon eri kuvat ovat sheetBat-muuttujassa
	local sheetBatData = { width=32, height=32, numFrames=16, sheetContentWidth=128, sheetContentHeight=128 }
	local sheetBat = graphics.newImageSheet( "scenes/images/lepakko.png", sheetBatData )
	
	--Bat-hahmon fysiikat (mukaan lukien osumaboksit) tulevat 15. Bat-kuvaan perustuen
	local batFrameIndex = 15
	local batOutline = graphics.newOutline( 2, sheetBat, batFrameIndex )
	
	--Bat hahmon animaatiot asetetaan sheetBatSequenceData-muuttujaan
	local sheetBatSequenceData = {
	{ name = "lento",
	start = 14,
	count = 3,
	time = 280,
	loopCount = 0
	}
	}	
	
	--Itse Bat-hahmon luominen display-objektiksi
	bat = display.newSprite( sheetBat, sheetBatSequenceData )
	bat.isFixedRotation = true
	bat.speed = 5
	physics.addBody( bat, "static", { outline=batOutline, friction=0.5, bounce=0.0, density=1.0 } )
	bat.objType = "enemy"
	sceneGroup:insert( bat )
	
		
	--=Mage-hahmon asetteleminen	
	
	--Mage-hahmon eri kuvat ovat sheetBat-muuttujassa
	local sheetMageData = { width=64, height=64, numFrames=20, sheetContentWidth=576, sheetContentHeight=256 }
	local sheetMage = graphics.newImageSheet( "scenes/images/magekavely.png", sheetMageData )
	
	--Mage-hahmon fysiikat (mukaan lukien osumaboksit) tulevat 18. Mage-kuvaan perustuen
	local mageFrameIndex = 18
	local mageOutLine = graphics.newOutline ( 2, sheetMage, mageFrameIndex )
	
	--Mage hahmon animaatiot asetetaan sheetBatSequenceData-muuttujaan
	local sheetMageSequenceData = {
	{ name = "kavely",
	start = 10,
	count = 9,
	time = 280,
	loopCount = 0
	}
	}
	
	--Itse Mage-hahmon luominen display-objektiksi
	mage = display.newSprite( sheetMage, sheetMageSequenceData )
	mage.anchorX = 0.5
	mage.anchorY = 1.0
	mage.isFixedRotation = true
	mage.speed = 4
	physics.addBody( mage, "static", { outline=mageOutLine, friction=0.5, bounce=0.0, density=1.0} )
    mage.objType = "enemy"
	sceneGroup:insert( mage )
					
	--=Tämä metodi vierittää display-objektia sen nopeuden verran vasemmalle.
	-- ja jos se menee sille objektille annetun leveys-arvon yli se siirtää sen takaisin näytön oikeaan reunaan
	function scrollBackground(self, event)
		
		if composer.getSceneName( "current" ) == "scenes.game" then
			if self.x < -self.leveys then
				self.x = self.leveys
			else
				self.x = self.x - self.speed -baseSpeed
			end
		else
		
		end
	end
	
	--=Lisätään scrollBackground-funktio taustan objekteille, joiden halutaan liikkuvan.
	-- enterFrame tapahtuma toteutuu jokaisella kerralla kun näyttö päivittyy.
	buildings.enterFrame = scrollBackground
	buildings2.enterFrame = scrollBackground
	asphalt.enterFrame = scrollBackground
	asphalt2.enterFrame = scrollBackground
	brickwall.enterFrame = scrollBackground
	brickwall2.enterFrame = scrollBackground
	
	--=Funktio pisteiden lisäämiseen
	function updateScore()
		if (composer.getSceneName( "current" ) == "scenes.game") then
		score = score + 1
		scoreText.text = "Score: " .. score		
		end
	end
			
			
	function increaseSpeed()
		baseSpeed = baseSpeed + 1
	end
			
	--=Lepakon funktioita
	function moveBat(self, event)
		if self.x < -150 then
			self.x = 800
			self.y = math.random(180,250)
			timer.performWithDelay(math.random(1000,8000), resetBatSpeed)
			self.speed = 0
		elseif (self.speed > 0) then
			self.x = self.x - self.speed - baseSpeed
		end
	end
		
	function resetBatSpeed()
		bat.speed = 5
	end

	bat.enterFrame = moveBat
	
	--=Magen funktioita
	function moveMage(self, event)
		if self.x < -150 then
			self.x = 800
			self.y = 270
			timer.performWithDelay(math.random(1000,8000), resetMageSpeed)
			self.speed = 0
		elseif (self.speed > 0) then
			self.x = self.x - self.speed - baseSpeed
		end
	end	
	
	function resetMageSpeed()
		mage.speed = 4
	end
	
	mage.enterFrame = moveMage
	
	--=Hyppy toiminto. Ensin on kuitenkin tarkistettava onko hahmo maassa ennen kuin siirrämme pelattavaa hahmoa ylemmäs
	function touchAction( event )
		if ( event.phase == "began" and fumiko.sensorOverlaps == 1 ) then	
		
			audio.play( jumpSound, { channel = 2 } )	
			local vx, vy = fumiko:getLinearVelocity()
			fumiko:setLinearVelocity( vx, 0 )
			fumiko:applyLinearImpulse( nil, -18, fumiko.x, fumiko.y )
			
		end
	end

	--=SensorCollide-funktio on fumiko-hahmon osumissensori ja sitä kutsutaan aina kun fumiko-hahmo osuu toiseen fysiikka-objektiin.
	--=Fumiko hahmolle on luotu niin sanottu "jalkasensori", joka mahdollistaa hypyn hieman ennen kuin hahmo on todellisuudessa maassa.
	-- Se on näillä asetuksilla Fumiko-hahmon 6. selfElement.
	function sensorCollide( self, event )
		-- Tarkistetaan, että osuvat kohteet ovat jalkasensori ja maatyypin objekti
		if ( event.selfElement == 6 and event.other.objType == "ground" ) then
		
			-- Jalkasensori on mennyt maan sisään
			if ( event.phase == "began" ) then
				self:setSequence( "laskeutuminen" )
				self:play()
				self.sensorOverlaps = 1
			-- Jalkasensori on poistunut maan sisästä
			elseif ( event.phase == "ended" ) then
				self:setSequence( "hyppy" )
				self:play()
				self.sensorOverlaps = 0
			end
		elseif ( event.other.objType == "enemy" and  event.phase == "began" and event.selfElement ~= 6 ) then
			updateOptions(score)
			composer.gotoScene( "scenes.restart", options )
		end
	end
	-- Asetetaan fumiko-hahmolle törmäyksen-käsittelijä
	fumiko.collision = sensorCollide
	
	
	--=Tällä funktiolla päivitetään uusimmat pisteet vietäväksi seuraavaan sceneen
	function updateOptions(yourScore)			
		options =
		{
			effect = "fade",
			time = 800,
			params = {
				score = yourScore
			}
		}
	end
	
	
	--Funktio, jolla saadaan laskeutumis-animaation jälkeen vaihdettua juoksuanimaatio
	function spriteListener( event )
	 
		local thisSprite = event.target

		if ( event.phase == "ended" and event.target.sequence == "laskeutuminen") then 
			fumiko:setSequence( "juoksu" )
			fumiko:play()
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
		bat.x = -200
		bat.y = math.random(180,250)
		mage:setSequence( "kavely" )
		mage:play()
		mage.x = -200
		mage.y = 270
		score = 0
		baseSpeed = 0
		
		
		scoreTimer = timer.performWithDelay(500, updateScore, -1)
		speedTimer = timer.performWithDelay(10000, increaseSpeed, -1)
			
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
		Runtime:addEventListener("enterFrame", mage)
		
		
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		
		gameMusicChannel = audio.play( gameMusic, { channel=1, loops=-1 } )
		audio.setVolume( 0.15, { gameMusicChannel } )
		audio.setVolume( 0.90, { channel = 2 } )
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
		mage:pause()
		timer.cancel(scoreTimer)
		audio.rewind( { channel = 1 } )
		audio.stop( { channel = 1 } )
		
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
		scoreText.text = "Score: 0"		
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