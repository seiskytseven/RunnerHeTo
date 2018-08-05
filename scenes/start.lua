-----------------------------------------------------------------------------------------
--
-- template.lua
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
local background
local startButton
local startText
local clickSound
local menuMusic
local menuMusicChannel

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
		
	clickSound = audio.loadSound( "scenes/sounds/click.mp3" )
	menuMusic = audio.loadStream( "scenes/musics/Harp.mp3" )
	
	paint = {
	type = "gradient",
	color1 = { 0, 0.3, 0.4 },
	color2 = { 0, 0.3, 0.2, 0.2},
	direction = "up"
	}
	
	paint2 = {
	type = "gradient",
	color1 = { 0.7, 0.7, 0.7 },
	color2 = { 0.5, 0.5, 0.5, 0.2},
	direction = "down"
	}
		
	background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, 700, 320 )
	background.fill = paint
	
	startButton = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, 300, 80, 10 )
	startButton.fill = paint2
	
	startText = display.newText ( sceneGroup, "Start Game", display.contentCenterX, display.contentCenterY, native.systemFont, 40 )
	startText:setFillColor( 0.1, 0.2, 0.2 )
	
	local function onObjectTouch( event )
		if ( event.phase == "began" ) then
		elseif ( event.phase == "ended" ) then
			audio.play( clickSound )
			composer.gotoScene( "scenes.game", "fade", 600 )
			
		end
		return true
	end
	
	startButton:addEventListener( "touch", onObjectTouch )

	
	menuMusicChannel = audio.play( menuMusic, { channel=1, loops=-1 } )
	
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		audio.resume( menuMusicChannel )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
		audio.rewind( {channel = 1} )
		audio.stop( {channel = 1} )
 
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