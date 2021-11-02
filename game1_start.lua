-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image1/before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local gameName = display.newText("카드 짝 맞추기 게임", bg.x, bg.y-80, "font/NanumSquareB.ttf", 80)
	gameName:setFillColor(0)

	local explanation = display.newText("STAGE 1", bg.x, gameName.y -130, "font/NanumSquareB.ttf", 40)
	explanation:setFillColor(0)

	local startButton = display.newText("GAME START", bg.x, bg.y+80, "font/NanumSquareB.ttf", 60)
	startButton:setFillColor(0)
	startButton.alpha = 0

	local function flashing_text(textToFlash)
	    local r = math.random(0,100)
	    local g = math.random(0,100)
	    local b = math.random(0, 100)

	    if(textToFlash.alpha < 1) then
	        --textToFlash:setFillColor(r/100,g/100,b/100)
	        transition.to( textToFlash, {time=490, alpha=1})
	    else 
	        transition.to( textToFlash, {time=490, alpha=0.1})
	    end
    end
	local txt_flash = timer.performWithDelay(550, function() flashing_text(startButton) end, 0)

	-- 게임파일로 이동하는 함수
	local function startGame(event)
		
		composer.removeScene("game1_start")
	   	composer.gotoScene("game1")

	   	sceneGroup:insert(bg)
	   	sceneGroup:insert(explanation)
	   	sceneGroup:insert(gameName)
	   	sceneGroup:insert(startButton)
	end

	startButton:addEventListener("tap", startGame)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene