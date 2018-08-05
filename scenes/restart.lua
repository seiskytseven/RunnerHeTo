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
local box
local startButton
local restartMusic
local restartMusicChannel
local clickSound
local scoreboard
local params
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	clickSound = audio.loadSound( "scenes/sounds/click.mp3" )
	restartMusic = audio.loadStream( "scenes/musics/ambientmain_0.ogg" )
	
	paint = {
	type = "gradient",
	color1 = { 0.4, 0.1, 0.2 },
	color2 = { 0.2, 0.1, 0.2, 0.2},
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
	
	box = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, 300, 80, 10 )
	box.fill = paint2
	
	startButton = display.newText ( sceneGroup, "Try again", display.contentCenterX, display.contentCenterY, native.systemFont, 40 )
	startButton:setFillColor( 0.1, 0.2, 0.2 )
	
	scoreboard = display.newText( sceneGroup, "Your score: 0", display.contentCenterX, display.contentCenterY-70, native.systemFont , 30)
	scoreboard.fill = paint2
	
	local function onObjectTouch( event )
		if ( event.phase == "began" ) then
		elseif ( event.phase == "ended" ) then
			audio.play( clickSound )
			composer.gotoScene( "scenes.game", "fade", 600 )
			
		end
		return true
	end
	
	box:addEventListener( "touch", onObjectTouch )
	
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		
		params = event.params
		scoreboard.text = "Your score: " .. params.score
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen		
		restartMusicChannel = audio.play( restartMusic, { channel=1, loops=-1 } )
		audio.setVolume( 0.6, { restartMusicChannel } )
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