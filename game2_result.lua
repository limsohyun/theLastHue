-----------------------------------------------------------------------------------------
--
-- game2_result.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local stage = composer.getVariable("finalStage")
local life = composer.getVariable("finalLife")
local max_stage = composer.getVariable("maxStage")

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image2/afternoon_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2
	
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha = 0
	line1.alpha = 0

	local txt = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
    txt:setFillColor(1)
    txt.alpha = 0

    local tapButton = display.newImageRect("image2/click.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 0

    local tNum = 0
    --------------------
	local endText = display.newText("", display.contentWidth/2, display.contentHeight/2-50, "font/NanumSquareEB.ttf", 100)
	endText:setFillColor(0)
	endText.alpha = 0 

	local retry = display.newText("다시 도전하기!", endText.x, endText.y+85, "font/NanumSquareEB.ttf", 30)
	retry:setFillColor(0)
	retry.alpha = 0

	local quit = display.newText("미니게임 나가기", endText.x, endText.y+85, "font/NanumSquareEB.ttf", 30)
	quit:setFillColor(0)
	quit.alpha = 0
	--------------------
	local function showPlayerName()
		transition.to(player, {time=1000, delay=1200, alpha=1})
		transition.to(line1, {time=1000, delay=1200, alpha=1})
	end

	-- 대사창 보이게 하는 함수 
	local function showChat()
		print("called showChat()")
		txt.x = 135
		txt.text = "으으... 정말 어렵네......"
		tNum = tNum + 1

		transition.to(txtBox, {time=1000, delay=1200, alpha=0.9})
	    transition.to(tapButton, {time=1000, delay=1200, alpha=1})
		transition.to(txt, {time=1000, delay=1200, alpha=1})
		showPlayerName()
	end

	-- 게임 오버 시 게임을 재시도하는 함수. 게임 파일로 재이동함
	local function retryGame(event)
		print("retry game clicked")

		sceneGroup:insert(bg)
		sceneGroup:insert(endText)
		sceneGroup:insert(retry)
		sceneGroup:insert(quit)
		sceneGroup:insert(txtBox)
		sceneGroup:insert(player)
		sceneGroup:insert(line1)
		sceneGroup:insert(txt)
		sceneGroup:insert(tapButton)

		retry:removeEventListener("tap", retryGame)
		composer.removeScene("game2_result")
	   	composer.gotoScene("game2_start")
	end
	
	-- 게임 클리어 시 다음 화면으로 전환하는 함수
	local function quitGame(event)
		print("quit game clicked")
		
		sceneGroup:insert(bg)
		sceneGroup:insert(endText)
		sceneGroup:insert(retry)
		sceneGroup:insert(quit)

		quit:removeEventListener("tap", quitGame)
		composer.removeScene("game2_result")
	   	composer.gotoScene("script2_2")
	end

	-- 종료 조건 --
	if stage > max_stage then
		endText.text = "CLEAR"
	    transition.to(endText, {time=3000, delay=500, alpha=1})
	    transition.to(quit, {time=3200, delay=1500, alpha=1})
		quit:addEventListener("tap", quitGame)
	elseif life < 1 then
		endText.text = "GAME OVER"
		transition.to(endText, {time=3000, delay=500, alpha=1})
	    showChat()
	end	

	local function txtEvent(evnet)
		if tNum == 2 then
			txt.x = 100
			txt.text = "다시 해볼까?"
			transition.to(retry, {time=1000, delay=1200, alpha=1})
			tapButton.alpha = 0

			retry:addEventListener("tap", retryGame)
		end
	end

	-- 대화창에 있는 하단 이미지. 누르면 대화 진행, 대화 종료
    local function tapButtonEvent(event)
    	print("tapped")
    	tNum = tNum + 1
    	txtEvent()
    end
	tapButton:addEventListener("tap", tapButtonEvent)
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
