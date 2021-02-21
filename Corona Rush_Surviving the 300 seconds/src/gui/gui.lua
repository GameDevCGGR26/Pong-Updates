local GUI = {}

function GUI:load()
	self.coins = {} --coins images and constants
	self.coins.img = love.graphics.newImage("assets/coinsingle.png")
	self.coins.width = self.coins.img:getWidth()
	self.coins.height = self.coins.img:getHeight()
	self.coins.scale = 4
	self.coins.x = love.graphics.getWidth() - 200 --upper leftmost corner
	self.coins.y = 30

	self.hearts = {} --hearts images and constants
	self.hearts.img = love.graphics.newImage("assets/heartsingle.png")
	self.hearts.width = self.hearts.img:getWidth()
	self.hearts.height = self.hearts.img:getHeight()
	self.hearts.scale = 5
	self.hearts.x = 0
	self.hearts.y = 10
	self.hearts.spacing = self.hearts.width * self.hearts.scale + 5
	if charNum == 3 then
		self.health = {current = 4, max = 4}
	else
		self.health = {current = 3, max = 3}
	end

	self.powerupBar = {}
	self.isDisplayFaceshield = false
	self.isDisplayAlcohol = false
	self.isDisplayPPE = false
	self.isDisplayMask = false
	self.faceshieldBar = 0
	self.alcoholBar = 0
	self.ppeBar = 0
	self.maskBar = 0
	self.mBarDisplay = 1
	self.fBarDisplay = 1
	self.aBarDisplay = 1
	self.pBarDisplay = 1
	self.powerupBar.x = 10
	self.powerupBar.y = 85
	self.powerupBar.scale = 8

	if charNum == 4 then
		self.isDisplayMask = true
		self.maskBar = 1
		self.mBarDisplay = 1
	elseif charNum < 4 then
		self.isDisplayMask = false
		self.maskBar = 0
		self.mBarDisplay = 1
	end

	self.testingcenter = {}
	self.testingcenter.x = 100
	self.testingcenter.y = 110
	self.testingcenter.scale = 1

	self.testingcenterDisplay = 0

	self.font = love.graphics.newFont("assets/font/bit.ttf", 36) --coin count font
end

function GUI:update(dt)
  
end

function GUI:draw()
	self:displayCoins()
	self:displayCoinText()
	self:displayHearts ()
	self:displayPowerupBar()
	self:displayTime()
end

function GUI:displayPowerupBar()
	if self.isDisplayFaceshield == true then
		if charNum == 1 then
			love.graphics.draw(gTextures.faceshieldBar, gFrames.faceshieldBar[self.fBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		elseif charNum > 1 then
			love.graphics.draw(gTextures.nfaceshieldBar, gFrames.nfaceshieldBar[self.fBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		end
	elseif self.isDisplayAlcohol == true then
		if charNum == 1 then
			love.graphics.draw(gTextures.alcoholBar, gFrames.alcoholBar[self.aBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		elseif charNum > 1 then
			love.graphics.draw(gTextures.nalcoholBar, gFrames.nalcoholBar[self.aBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		end
	elseif self.isDisplayPPE == true then
		if charNum == 1 then
			love.graphics.draw(gTextures.ppeBar, gFrames.ppeBar[self.pBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		elseif charNum > 1 then
			love.graphics.draw(gTextures.nppeBar, gFrames.nppeBar[self.pBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		end
	elseif self.isDisplayMask == true then
		if charNum == 1 then
			love.graphics.draw(gTextures.maskBar, gFrames.maskBar[self.mBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
		elseif charNum > 1 then
			love.graphics.draw(gTextures.nmaskBar, gFrames.nmaskBar[self.mBarDisplay], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)	
		end
	end
end

function GUI:displayHearts ()
    for i = 1, self.health.current do
		local x = self.hearts.x + self.hearts.spacing * i
		love.graphics.draw(self.hearts.img, x, self.hearts.y, 0, self.hearts.scale)
    end
end

function GUI:displayCoins()
	love.graphics.setColor(0,0,0,0.5) --shadow
	love.graphics.draw(self.coins.img, self.coins.x + 2, self.coins.y + 2, 0, self.coins.scale, self.coins.scale)
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scale, self.coins.scale)
end

function GUI:displayCoinText()
	love.graphics.setFont(self.font)
	local x = self.coins.x + self.coins.width * self.coins.scale
	local y = self.coins.y + self.coins.height / 2 * self.coins.scale - self.font:getHeight() / 2
	love.graphics.setColor(0,0,0,0.5) --shadow
	love.graphics.print(" : "..Player.coins, x + 2, y + 2)
	love.graphics.setColor(1,1,1,1)
	love.graphics.print(" : "..Player.coins, x, y)
end

function GUI:displayTime()
  	love.graphics.printf('Timer: ' .. tostring(TIMERS), 530, 30, 182, 'center')
end

return GUI
