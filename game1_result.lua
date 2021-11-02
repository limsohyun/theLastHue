-----------------------------------------------------------------------------------------
--
-- result.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 2) 전달한 변수값 불러오기
local resultScore = composer.getVariable("score")
local wrong = composer.getVariable("min")

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect( "image1/before.png", display.contentWidth, display.contentHeight )
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local endText = display.newText(" ", display.contentWidth/2, display.contentHeight/2 - 50)
	endText.size = 150
	endText:setFillColor(0)

	local retry = display.newText("RETRY", display.contentWidth/2, display.contentHeight/2 + 80)
	retry.size = 100
	retry:setFillColor(0)
	retry.alpha = 0


	local quit = display.newText(" ", display.contentWidth/2, display.contentHeight/2 + 80)
	quit.size = 100
	quit:setFillColor(0)

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

	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0)
	txtBox.alpha = 0
	
    local tapButton = display.newImageRect("image1/button.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 0

	local boxText = display.newText("이럴 순 없어…", display.contentWidth/2, display.contentHeight/2+230, "font/NanumSquareR.ttf", 25)
	boxText:setFillColor(1)
	boxText.alpha = 0

	local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
    player.alpha = 0
    line1.alpha = 0

 	local function endGame(event)
		composer.removeScene("game1_result")

		sceneGroup:insert(bg)
		sceneGroup:insert(endText)
	   	sceneGroup:insert(quit)
	   	sceneGroup:insert(txtBox)
	   	sceneGroup:insert(boxText)
	   	sceneGroup:insert(player)
	    sceneGroup:insert(retry)
		sceneGroup:insert(tapButton)
	   	sceneGroup:insert(line1)

	   	composer.gotoScene("script1_2")
	end

	local function reGame(event)
		composer.removeScene("game1_result")

		sceneGroup:insert(bg)
		sceneGroup:insert(endText)
	    sceneGroup:insert(retry)
	   	sceneGroup:insert(quit)
	   	sceneGroup:insert(txtBox)
	   	sceneGroup:insert(boxText)
	   	sceneGroup:insert(player)
		sceneGroup:insert(tapButton)
	   	sceneGroup:insert(line1)
		
	   	composer.gotoScene("game1_start")
	end

	if resultScore > wrong then
		endText.text = "CLEAR"
		quit.text = "quit"
		quit:addEventListener("tap", endGame)
		local txt_flash1 = timer.performWithDelay(550, function() flashing_text(quit) end, 0)
	else
		endText.text = "GAME OVER"
		tapButton.alpha = 1
		txtBox.alpha = 1
		boxText.alpha = 1
 		local function tapButtonEvent(event)
	    	print( "Button was pressed and released" )
    		boxText.text = "다시 한 번 해보자."
    		retry.alpha = 1
			local txt_flash2 = timer.performWithDelay(550, function() flashing_text(retry) end, 0)
			retry:addEventListener("tap", reGame)
  		  end

			tapButton:addEventListener("tap", tapButtonEvent)
 		end 
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