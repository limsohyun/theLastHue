-----------------------------------------------------------------------------------------
--
-- game2_start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("image2/afternoon_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local name = display.newText("조각 모으기 게임", bg.x, bg.y-80, "font/NanumSquareEB.ttf", 80)
	name:setFillColor(0)

	local start = display.newText("GAME START", bg.x, bg.y+80, "font/NanumSquareEB.ttf", 60)
	start:setFillColor(0)
	start.alpha = 0

	local stage3 = display.newText("STAGE 3", bg.x, name.y-130, "font/NanumSquareEB.ttf", 40)
	stage3:setFillColor(0)

	local box = display.newRoundedRect(bg.x, 600, 500, 170, 20)
	box.alpha = 0.5

	local gameTip = display.newText("", box.x, box.y+20, "font/NanumSquareB.ttf", 18)
	gameTip.text = "1.화살표키를 눌러 움직이며 바구니에 조각 10개를 담는다."..
					"\n2. 빨간색 조각을 5개 이상 모으면 게임 클리어!"..
					"\n3. 단 , 숲더미를 담게 된다면 바로 게임오버!!"
	local gameTip1 = display.newText("<게임 방법>", box.x, gameTip.y-80, "font/NanumSquareB.ttf", 19)
	gameTip:setFillColor(0)
	gameTip1:setFillColor(0)

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
	local txt_flash = timer.performWithDelay(1, function() flashing_text(start) end, 0)

	-- 게임파일로 이동하는 함수
	local function gotoGame(event)
		print("게임 파일로 이동함")
		sceneGroup:insert(bg)
		sceneGroup:insert(name)
		sceneGroup:insert(start)
		sceneGroup:insert(box)
		sceneGroup:insert(gameTip)
		sceneGroup:insert(gameTip1)
		sceneGroup:insert(stage3)
		start:removeEventListener("tap", gotoGame)
		composer.removeScene("game3_start")
	   	composer.gotoScene("game3", {effect = "fade", time = 2000})
	end
	start:addEventListener("tap", gotoGame)
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