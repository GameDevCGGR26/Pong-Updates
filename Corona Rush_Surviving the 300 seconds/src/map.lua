local Map = {}

function Map:load()
	self.currentLevel = 1
	World = love.physics.newWorld(0,2000)
	World:setCallbacks(beginContact, endContact)

	self:init()
end

function Map:init()
	self.level = STI("map/"..self.currentLevel..".lua", {"box2d"})

	self.level:box2d_init(World)
	self.entityLayer = self.level.layers.entity
	self.objLayer = self.level.layers.obj
	MapWidth = self.level.width * self.level.tilewidth
	MapHeight = self.level.height * self.level.tileheight

	self:spawnEntities()
	self:spawnObjects()
end

function Map:backGround()
	if self.currentLevel == 1  then
		return gTextures.background

	elseif self.currentLevel == 2  then
		return gTextures.background2

	elseif self.currentLevel == 3  then
		return gTextures.background

	end
end

function Map:positionCamera(player, camera)
	local halfScreen =  VIRTUAL_WIDTH / 2

	if Player.x < (MapWidth - halfScreen) then
		boundX = math.max(0, Player.x - halfScreen) -- lock camera at the left side of the screen.
	else
		boundX = math.min(Player.x - halfScreen, MapWidth - VIRTUAL_WIDTH) -- lock camera at the right side of the screen
	end

   	Camera:setPosition(boundX, 0)
end

--[[
  function to go to the next level
]]
function Map:next()
	self:clean()
	self.currentLevel = self.currentLevel + 1
	self:init()

	Player:resetPosition()
end
--[[
  clean all the objects
]]
function Map:clean()
	self.level:box2d_removeLayer("solid")
	 Coin.removeAll()
    Alcohol.removeAll()
    Faceshield.removeAll()
    Mask.removeAll()
    Ppe.removeAll()
    Virus.removeAll()
    TestingCenter.removeAll()
end

function Map:deleteAll()
    Coin.removeAll()
    Alcohol.removeAll()
    Faceshield.removeAll()
    Mask.removeAll()
    Ppe.removeAll()
    Virus.removeAll()
    TestingCenter.removeAll()
end

function Map:update(dt)
	-- if player goes to the testeing center
	if GUI.testingcenterDisplay == 1 then
--gStateMachine:change('next-level')
--gStateMachine:change('play')
self:next()
GUI.testingcenterDisplay = 0
TIMERS = 300
GUI.isDisplayFaceshield = false
GUI.isDisplayAlcohol = false
GUI.isDisplayPPE = false

if charNum == 4 then
	GUI.isDisplayMask = true
	GUI.maskBar = 1
	GUI.mBarDisplay = 1
elseif charNum < 4 then
	GUI.isDisplayMask = false
	GUI.maskBar = 0
	GUI.mBarDisplay = 1
end

if charNum == 3 then
	GUI.health = {current = 4, max = 4}
else
	GUI.health = {current = 3, max = 3}
end--]]
	end

	if GUI.health.current == 0 then
		Map:deleteAll()
		Timer.clear()
	end

	-- if Player.x > MapWidth - 16 then
	-- 	self:next()
	-- end

--[[	if Player.y > MapHeight then
		Player:die()
		self:spawObjects()
	end]]--
end

function Map:spawnEntities()
	for i,j in ipairs(self.entityLayer.objects) do
		if j.type == "enemy" then
			Virus:load(j.x + j.width / 2, j.y + j.height)
		elseif j.type == 'player' then
			 Player:load(j.x + j.width/2, j.y+j.height/2)
		end
	end
end

function Map:spawnObjects()
	for i,j in ipairs(self.objLayer.objects) do
		if j.type == "coin" then
			Coin:new(j.x, j.y)
		end
		if j.type == "mask" then
			Mask:new(j.x, j.y)
		end
		if j.type == "faceshield" then
			Faceshield:new(j.x, j.y)
		end
		if j.type == "ppe" then
			Ppe:new(j.x, j.y)
		end
		if j.type == "alcohol" then
			Alcohol:new(j.x, j.y)
		end
		if j.type == "testingcenter" then
			print('spawn')
			TestingCenter:new(j.x + j.width / 2, j.y + j.height)
		end
	end
end


return Map
