-----------------------------------------------------------------------------------------
--
-- game2.lua
--
-----------------------------------------------------------------------------------------
math.randomseed(os.time()) -- random seed

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect("image2/afternoon_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local max_stage = 5
	local stageCount = 1
	local lifeCount = 5

	local stageUI = {} -- 스테이지 바 달성도 display object
	local lifeUI = {} -- 라이프 하트 display object
	local playerUI -- 스테이지 밑 캐릭터 보이기 display object
	local arrowUI = {}

	arrowUI[0] = graphics.newImageSheet("image2/key_ver1.png", {width = 500, height = 500, numFrames = 10})
	for i = 1, 10, 1 do
		-- 방향키 화면에 표시
		arrowUI[i] = {}
		arrowUI[i][1] = display.newImageRect(arrowUI[0], 1, 90, 90)
		arrowUI[i][2] = display.newImageRect(arrowUI[0], 2, 90, 90)
		arrowUI[i][3] = display.newImageRect(arrowUI[0], 3, 90, 90)
		arrowUI[i][4] = display.newImageRect(arrowUI[0], 4, 90, 90)
		arrowUI[i][5] = display.newImageRect(arrowUI[0], 5, 90, 90)
		arrowUI[i][6] = display.newImageRect(arrowUI[0], 6, 90, 90)
		arrowUI[i][7] = display.newImageRect(arrowUI[0], 7, 90, 90)
		arrowUI[i][8] = display.newImageRect(arrowUI[0], 8, 90, 90)
		arrowUI[i][9] = display.newImageRect(arrowUI[0], 9, 90, 90)
		arrowUI[i][10] = display.newImageRect(arrowUI[0], 10, 90, 90)
	end

	for i = 1, 10 , 1 do
		for j = 1, 10, 1 do
			arrowUI[i][j].alpha = 0
			arrowUI[i][j].x, arrowUI[i][j].y = 100+ 120*(i-1), display.contentHeight/2
		end
	end
	----------------------------------------------------------------------------

	-- 스테이지 바
	local stageText = display.newText("STAGE: ", 130, 50, "font/NanumSquareEB.ttf", 30)
	stageText:setFillColor(0)
	local stageBar = display.newRect(200, stageText.y+50, 250, 30)
	stageBar.fill.a = 0.8

	for i = 1, 5, 1 do
		stageUI[i] = display.newRect(50+(i*50), stageBar.y, 50, 30) -- 스테이지 바
		stageUI[i].alpha = 0
		stageUI[i]:setFillColor(1, 0.9, 0, 0.5)
	end
	playerUI = display.newImage("image2/player_icon.png", stageUI[1].x-25, stageUI[1].y+35)

	-- 잔여 라이프
	local lifeText = display.newText("LIFE: ", 1000, 50, "font/NanumSquareEB.ttf", 30)
	lifeText:setFillColor(0)
	local j = 0
	for i = 1, lifeCount, 1 do
		lifeUI[i] = display.newImage("image2/life.png", 980+(j*40), lifeText.y+50)
		lifeUI[i].height = 30
		lifeUI[i].width = 30
		j = j+1
	end
    
	-- 종료 조건 함수
	local function gotoResult()
		print("gotoResult() 실행")
    	composer.setVariable("finalStage", stageCount)
    	composer.setVariable("finalLife", lifeCount)
    	composer.setVariable("maxStage", max_stage)
    	
    	sceneGroup:insert(bg)
		sceneGroup:insert(stageText)
		sceneGroup:insert(stageBar)
		sceneGroup:insert(lifeText)
		for i = 1, 10, 1 do
			for j = 1, 10, 1 do
				sceneGroup:insert(arrowUI[i][j])
			end
		end
		for i = 1, 5, 1 do sceneGroup:insert(lifeUI[i]) end
		for i = 1, 5, 1 do sceneGroup:insert(stageUI[i]) end
		sceneGroup:insert(playerUI)

		composer.removeScene("game2")
    	composer.gotoScene("game2_result")
    end

    local view = {} -- 화살표의 위치
    local function makeView()
    	view[0] = 1
    	if view[1] ~= nil then -- 플레이 2회차부터 불투명도 초기화
    		for i = 1, 10, 1 do
    			arrowUI[i][view[i]].alpha = 0
    		end
    	end

    	print("랜덤 함수로 방향키 생성")
    	for i = 1, 10, 1 do
    		view[i] = math.random(1,10)
    		arrowUI[i][view[i]].alpha = 0.8
    	end
    end
    makeView() -- 일단 한번 실행

	-- 화살표 입력했을 경우의 이벤트 함수 --
	local function onKeyEvent(event)
		local temp = 0 -- UI scenegroup 위해
		--local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase

		if event.phase == "down" then -- 방향키가 눌렸을 때만 체크
			--print(message)
	   		if event.keyName == "up" then
	   			if arrowUI[view[0]][1].alpha == 0.8 then -- 맞았을 때
	   				transition.to(arrowUI[view[0]][1], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][5].alpha == 0.8 then
	   				transition.to(arrowUI[view[0]][5], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][9].alpha == 0.8 then
	   				transition.to(arrowUI[view[0]][9], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][1].alpha ~= 0.8 or arrowUI[view[0]][5].alpha ~= 0.8 or arrowUI[view[0]][9].alpha ~= 0.8 then -- 다른 거 눌렸을 때
	   				lifeUI[lifeCount].isVisible = false
					lifeUI[lifeCount] = display.newImage("image2/clear_life.png", lifeUI[lifeCount].x, lifeUI[lifeCount].y)
					lifeUI[lifeCount].height = 30
					lifeUI[lifeCount].width = 30
					lifeCount = lifeCount - 1
					makeView() -- 아이콘 초기화
	   			end 		
	   		elseif event.keyName == "down" then
	   			if arrowUI[view[0]][2].alpha == 0.8 then -- 맞았을 때
	   				transition.to(arrowUI[view[0]][2], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][6].alpha == 0.8 then
					transition.to(arrowUI[view[0]][6], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][10].alpha == 0.8 then
					transition.to(arrowUI[view[0]][10], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][2].alpha ~= 0.8 or arrowUI[view[0]][6].alpha ~= 0.8 or arrowUI[view[0]][10].alpha ~= 0.8 then -- 다른 거 눌렸을 때
	   				lifeUI[lifeCount].isVisible = false
					lifeUI[lifeCount] = display.newImage("image2/clear_life.png", lifeUI[lifeCount].x, lifeUI[lifeCount].y)
					lifeUI[lifeCount].height = 30
					lifeUI[lifeCount].width = 30
					lifeCount = lifeCount - 1
	   				makeView() -- 아이콘 초기화
	   			end
	   		elseif event.keyName == "left" then
	   			if arrowUI[view[0]][3].alpha == 0.8 then -- 맞았을 때
	   				transition.to(arrowUI[view[0]][3], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][7].alpha == 0.8 then
	   				transition.to(arrowUI[view[0]][7], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][3].alpha ~= 0.8 or arrowUI[view[0]][7].alpha ~= 0.8 then -- 다른 거 눌렸을 때
	   				lifeUI[lifeCount].isVisible = false
					lifeUI[lifeCount] = display.newImage("image2/clear_life.png", lifeUI[lifeCount].x, lifeUI[lifeCount].y)
					lifeUI[lifeCount].height = 30
					lifeUI[lifeCount].width = 30
					lifeCount = lifeCount - 1
	   				makeView() -- 아이콘 초기화
	   			end
	   		elseif event.keyName == "right" then
	   			if arrowUI[view[0]][4].alpha == 0.8 then -- 맞았을 때
	   				transition.to(arrowUI[view[0]][4], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1
	   			elseif arrowUI[view[0]][8].alpha == 0.8 then
	   				transition.to(arrowUI[view[0]][8], {time = 300, alpha = 0})
	   				view[0] = view[0] + 1		
	   			elseif arrowUI[view[0]][4].alpha ~= 0.8 or arrowUI[view[0]][8].alpha ~= 0.8 then -- 다른 거 눌렸을 때
	   				lifeUI[lifeCount].isVisible = false
					lifeUI[lifeCount] = display.newImage("image2/clear_life.png", lifeUI[lifeCount].x, lifeUI[lifeCount].y)
					lifeUI[lifeCount].height = 30
					lifeUI[lifeCount].width = 30
					lifeCount = lifeCount - 1
	   				makeView() -- 아이콘 초기화
	   			end
	   		end
	   		--print("현재 view[0]는: "..view[0])

	   		if view[0] > 10 then -- 스테이지를 다 깼을 때	
	   			stageUI[stageCount].alpha = 1
				playerUI.x = playerUI.x+50
   				stageCount = stageCount + 1
			
	   			timer.performWithDelay(300, makeView)
	   		end
   		end

   		-- 종료 조건 --
		if stageCount > max_stage or lifeCount == 0 then
			Runtime:removeEventListener("key", onKeyEvent)
			gotoResult()
		end
	end
	Runtime:addEventListener("key", onKeyEvent)
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
		composer.removeScene("game")
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
