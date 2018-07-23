-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

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
asphalt.y = 220
asphalt:scale( 0.33, 0.33 )
asphalt.speed = 4
asphalt.leveys = 1348


local asphalt2 = display.newImage("images/asphalt.jpg")
asphalt2.anchorX = 0.1
asphalt2.anchorY = 0.0
asphalt2.x = 1352
asphalt2.y = 220
asphalt2:scale( 0.33, 0.33 )
asphalt2.speed = 4
asphalt2.leveys = 1348


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

