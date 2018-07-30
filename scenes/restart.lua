-----------------------------------------------------------------------------------------
--
-- restart.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local bgColor
local buildingsGroup
local asphaltGroup
local brickwallGroup
local ground
local brickShadow
local fumiko
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	bgColor = require( "objects.bg" )
	sceneGroup:insert( bgColor )
	
	buildingsGroup = require( "objects.buildings" )
	sceneGroup:insert( buildingsGroup )
	
	asphaltGroup = require( "objects.asphalt" )
	sceneGroup:insert( asphaltGroup )
	
	brickwallGroup = require( "objects.brickwall" )
	sceneGroup:insert( brickwallGroup )
	
	brickShadow = require( "objects.brickShadow" )
	sceneGroup:insert( brickShadow )
	
	ground = require( "objects.ground" )
	sceneGroup:insert( ground )
	
	fumiko = require( "objects.fumiko" )
	sceneGroup:insert( fumiko )
	
	startButton = display.newText ( "Restart", display.contentCenterX, display.contentCenterY, native.systemFont, 40 )
	sceneGroup:insert( startButton )
	
	local function onObjectTouch( event )
		if ( event.phase == "began" ) then
			-- print( "Touch event began on: " .. event.target.id )
		elseif ( event.phase == "ended" ) then
			-- print( "Touch event ended on: " .. event.target.id )
			composer.gotoScene( "game", "fade", 100 )
			
		end
		return true
	end
	
	startButton:addEventListener( "touch", onObjectTouch )

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)	
		
		
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		fumiko:setSequence( "istuminen" )
		fumiko:play()		
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