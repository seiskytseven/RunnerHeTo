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
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	
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
	
	local function onObjectTouch( event )
		if ( event.phase == "began" ) then
			-- print( "Touch event began on: " .. event.target.id )
		elseif ( event.phase == "ended" ) then
			-- print( "Touch event ended on: " .. event.target.id )
			composer.gotoScene( "scenes.game", "fade", 100 )
			
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