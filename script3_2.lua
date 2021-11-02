-----------------------------------------------------------------------------------------
--
-- script3_2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image3/evening_after.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	-----  펜던트 나타나게 하기 위한 -----
	local appearEf = display.newImageRect("image3/appear.png", display.contentWidth, display.contentHeight)
	appearEf.x, appearEf.y = bg.x, bg.y
	appearEf.alpha = 0

	local pendant = display.newImage("image3/3.png", bg.x, bg.y)
	pendant.alpha = 0

    --- player 애니메이션 ---
    local sheetOptions1 =
    {
    	width = 396,
    	height = 720,
    	numFrames = 22
    }
    local sheet_player = graphics.newImageSheet("image3/player_sheet3.1.png", sheetOptions1)

    local sequences_player = {
    	{
			name = "shocked",
			frames = { 21, 21, 20, 20, 20, 21, 20, 20, 20, 20, 20, 20, 18 },
			time = 1500,
			loopCount = 1
    	},
    	{
			name = "blinking_shocked",
			frames = { 18, 18, 18, 18, 19, 18, 18, 18, 18 },
			time = 1500,
			loopCount = 0
    	},
    	{
    		name = "talking_smile",
    		frames = { 15, 16, 16, 15, 16, 16, 15, 17, 16, 16 },
    		time = 1500,
    		loopCount = 0,
    	},
    	{
			name = "talking_worried",
			frames = { 20, 21, 21, 20, 21, 21, 20, 22, 21, 21 },
			time = 1500,
			loopCount = 0
    	},
    	{
    		name = "blinking_smile",
    		frames = { 15, 15, 15, 15, 17, 15, 15, 15, 15 },
    		time = 1500,
    		loopCount = 0,
    	},
    	{
			name = "blinking_worried",
			frames = { 20, 20, 20, 20, 22, 20, 20, 20, 20 },
			time = 1500,
			loopCount = 0
    	}
    }
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
    player_animation.alpha = 0

	--- npc 애니메이션 ---
	local sheetOptions2 =
	{
		width = 602,
		height = 720,
		numFrames = 6
	}
	local sheet_npc = graphics.newImageSheet("image3/npc3_sheet1.png", sheetOptions2)
	
	local sequences_npc = {
		{
			name = "talking",
			frames = { 1, 4, 4, 1, 4, 4, 1, 5, 4, 4 }, 
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
		{
			name = "blinking", 
			frames = { 4, 4, 4, 4, 5, 4, 4 }, 
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
	}
	local npc_animation = display.newSprite(sheet_npc, sequences_npc)
	npc_animation.x, npc_animation.y = 1060, bg.y
	npc_animation.alpha = 0

	---------------
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha, line1.alpha = 0, 0

	local npc = display.newText("저녁의 사제", 102, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 113, 3, 10)
	npc.alpha, line2.alpha = 0, 0

	-- 대사 
    local txt = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
    txt.alpha = 0

    -- 시나리오 스크립트용
    local txt1 = display.newText("", bg.x, pendant.y+200, "font/NanumSquareB.ttf", 23)
	txt1:setFillColor(0)
	txt1.alpha = 0
	local txt2 = display.newText("", bg.x, txt1.y+30, "font/NanumSquareB.ttf", 23)
	txt2:setFillColor(0)
	txt2.alpha = 0
	
    local tapButton = display.newImageRect("image3/click.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 0

   	-- 대사 진행 정도
    local tNum = 0

	local function showPlayerName()
		player.alpha = 1
		line1.alpha = 0.6
	end

	local function hidePlayerName()
		player.alpha = 0
		line1.alpha = 0
	end

	local function showNpcName()
		npc.alpha = 1
		line2.alpha = 0.6
	end

	local function hideNpcName()
		npc.alpha = 0
		line2.alpha = 0
	end

	-- player 애니메이션 관련 함수 
	local function playerTalking()
		player_animation:setSequence("talking_worried")
		player_animation:play()
	end
	
	local function playerTalkingS()
		player_animation:setSequence("talking_smile")
		player_animation:play()
	end

	local function playerBlinking()
		player_animation:setSequence("blinking_worried")
		player_animation:play()
	end

	local function playerBlinkingS()
		player_animation:setSequence("blinking_smile")
		player_animation:play()
	end

	-- npc 애니메이션 관련 함수
	local function npcTalking()
		npc_animation:setSequence("talking")
		npc_animation:play()
	end

	local function npcBlinking()
		npc_animation:setSequence("blinking")
		npc_animation:play()
	end
	
	-- 팬던트가 배경과 함께 서서히 나타났다 사라지는 효과
	local function pendantEf()
		transition.to(appearEf, {time=2000, delay=1000, alpha=0.3})
	    transition.fadeIn(pendant, {time=2000, delay=1000})
	    transition.fadeOut(appearEf, {time=2000, delay=7000})
	    transition.fadeOut(pendant, {time=2000, delay=7000})
	end

	--다음 챕터로 이동하는 함수
	local function gotoNextScene()
		sceneGroup:insert(bg)
		sceneGroup:insert(txtBox)
		sceneGroup:insert(player)
		sceneGroup:insert(line1)
		sceneGroup:insert(npc)
		sceneGroup:insert(line2)
		sceneGroup:insert(tapButton)
		sceneGroup:insert(appearEf)
		sceneGroup:insert(pendant)
		sceneGroup:insert(txt)
		sceneGroup:insert(txt1)
		sceneGroup:insert(txt2)
		--npc 애니메이션 추가
		sceneGroup:insert(player_animation)
		sceneGroup:insert(npc_animation)

		composer.removeScene("script3_2")
    	composer.setVariable("stageNum",4)
     	composer.gotoScene("stage",{effect="fade",time=2000})
	end
	---------------------------------------------------- 대사 부분 ------------------------------------------------------
	-- 상황 설명이 끝난 후 대사창 보이게 하는 함수 
	local function showChat()
		print("called showChat()")
		transition.to(txtBox, {time=300, alpha=0.9})
	    transition.fadeIn(tapButton, {time=300})
	    transition.fadeIn(txt, {time=300})
		transition.fadeIn(showPlayerName(), {time=300})
		transition.fadeIn(npc_animation, {time=1000}) -- npc 등장 
		npcBlinking()
		
		transition.fadeIn(player_animation, {time=1000}) -- player 등장 
		playerTalkingS()
		txt.x = 390
		txt.text = "(잔뜩 밝아진 얼굴로 기쁨을 표출한다.) 우와, 사제님, 저 이제 거의 모든 색상이 돌아왔어요!"
		tNum = tNum + 1
	end

	-- 장면 전환 후 상황 설명
	if tNum == 0 then
		txt1.text = "미니게임을 통과한 로르는 붉은 빛이 감도는 펜던트 조각을 돌려받는다."
		txt2.text = "로르의 몸에 다시금 붉은 빛이 돌기 시작한다."

		pendantEf()
	    transition.fadeIn(txt1, {time=2000, delay=1000})
	   	transition.fadeIn(txt2, {time=2000, delay=1000})
	    transition.fadeOut(txt1, {time=2000, delay=7000})
	    transition.fadeOut(txt2, {time=2000, delay=7000})
	    timer.performWithDelay(9000, showChat)
	end

    local function txtEvent()
    	--print("tNum is.."..tNum)
		if tNum == 2 then
			npcTalking()
			playerBlinkingS()
			hidePlayerName()
			showNpcName()
			txt.x = 213
			txt.text = "(의기양양한 표정으로) 흥, 다 내 덕분이라고."
		elseif tNum == 3 then
			playerTalkingS()
			npcBlinking()
			hideNpcName()
			showPlayerName()
			txt.x = 155
			txt.text = "감사해요, 사제님! 드디어......"
		elseif tNum == 4 then
			player_animation:setSequence("shocked")
			player_animation:play()
			txt.x = 78
			txt.text = "...... 어?"
		elseif tNum == 5 then
			player_animation:setSequence("blinking_shocked")
			player_animation:play()
			hidePlayerName()
			showNpcName()
			txt.x = 70
			txt.text = "...... ?"
		elseif tNum == 6 then
			playerTalking() -- 곤란하게 말하는거
			npcBlinking()
			hideNpcName()
			showPlayerName()
			txt.x = 353
			txt.text = "(초조해하는 목소리와 떨리는 눈동자.)\n사제님, 생각해보니 아직 검은색이 돌아오지 않았어요! 시간이 얼마 안 남았는데..."
		elseif tNum == 7 then
			npcTalking()
			playerBlinking()
			hidePlayerName()
			showNpcName()
			txt.x = 305
			txt.text = "(사뭇 진지해진 목소리로 로르를 바라본다.)\n... 설마. 로르, 너는 밤의 사제를 찾아야 해. 그렇지만 밤의 사제는......"
		elseif tNum == 8 then
			playerTalking()
			npcBlinking()
			hideNpcName()
			showPlayerName()
			txt.x = 105
			txt.text = "밤의 사제는...?"
		elseif tNum == 9 then
			npcTalking()
			playerBlinking()
			hidePlayerName()
			showNpcName()
			txt.x = 370
			txt.text = "밤의 사제는, 어둠이 온 세상을 덮은 후에야 나타나기에 일반적인 방법으론 볼 수 없어."..
			"\n밤의 사제를 볼 수 있는 방법은 딱 하나, 바로 내면의 빛으로 그를 비추는 거야."
		elseif tNum == 10 then
			npcBlinking()
			playerTalking()
			hideNpcName()
			showPlayerName()
			txt.x = 97
			txt.text = "내면의 빛...?"
		elseif tNum == 11 then
			playerBlinking()
			npcTalking()
			hidePlayerName()
			showNpcName()
			txt.x = 622
			txt.text = "응, 밤의 사제를 만나고자 하는 마음에 어둠이 조금이라도 서려있다면, 그는 결코 나타나지 않아."..
			"\n부정이 완벽히 사라진 순수한 마음과 밤의 사제를 진정으로 찾고자 하는 마음이 하나가 되어 내면에서 빛이 생기면,"..
			"비로소 밤의 사제를 만날 수 있을 거야."
		elseif tNum == 12 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerTalking()
			txt.x = 255
			txt.text = "그렇다면... 내면의 빛은 스스로 터득해야 하는 거군요..."
		elseif tNum == 13 then
			hidePlayerName()
			showNpcName()
			playerBlinking()
			npcTalking()
			txt.x = 207
			txt.text = "맞아, 이번엔 나도 도와줄 수 없을 것 같네."
		elseif tNum == 14 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerBlinking()
			txt.x = 165
			txt.text = "...... (말없이 고개를 끄덕인다.)"
		elseif tNum == 15 then
			hidePlayerName()
			showNpcName()
			npcTalking()
			txt.x = 257
			txt.text = "하지만... 기운 내, 로르. 진정한 빛은 이미 네 안에 있어. "
		elseif tNum > 15 then
			gotoNextScene()
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
