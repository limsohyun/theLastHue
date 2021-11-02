-----------------------------------------------------------------------------------------
--
-- script2_2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image2/afternoon_after.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	-----  펜던트 나타나게 하기 위한 -----
	local appearEf = display.newImageRect("image2/appear.png", display.contentWidth, display.contentHeight)
	appearEf.x, appearEf.y = bg.x, bg.y
	appearEf.alpha = 0

	local pendant = display.newImage("image2/2.png", bg.x, bg.y)
	pendant.alpha = 0

 	--- player 애니메이션 ---
    local sheetOptions1 =
    {
    	width = 396,
    	height = 720,
    	numFrames = 17
    }
    local sheet_player = graphics.newImageSheet("image2/player_sheet2.1.png", sheetOptions1)

	local sequences_player = {
  		{
			name = "talking",
			frames = { 12, 13, 13, 12, 13, 13, 14, 14, 13, 13 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "talking_smile",
			frames = { 15, 16, 16, 15, 16, 16, 15, 17, 16, 16 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "blinking",
			frames = { 12, 12, 12, 12, 14, 12, 12, 12, 12 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
    		name = "blinking_smile",
    		frames = { 15, 15, 15, 15, 17, 15, 15, 15, 15 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    }
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
   	player_animation.alpha = 0

	--- npc 애니메이션 ---
	local sheetOptions = 
	{
		width = 565,
		height = 720,
		numFrames = 5
	}
	local sheet_npc = graphics.newImageSheet("image2/npc2_sheet.png", sheetOptions)

	local sequences_npc = {
		{
			name = "talking",
			frames = { 1, 2, 2, 1, 2, 2, 1, 3, 2, 2 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
		{
			name = "blinking",
			frames = { 2, 2, 2, 2, 3, 2, 2 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
		{
			name = "smiling",
			frames = { 4, 4, 4, 4, 5, 4, 4, 4, 4 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		}
	}
	local npc_animation = display.newSprite(sheet_npc, sequences_npc)
	npc_animation.x, npc_animation.y = 1000, bg.y
	npc_animation.alpha = 0

	---------------
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha = 0
	line1.alpha = 0

	local npc = display.newText("낮의 사제", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
	npc.alpha = 0
	line2.alpha = 0

	-- 대사
    local txt = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
	local txt1 = display.newText("", bg.x, pendant.y+200, "font/NanumSquareB.ttf", 23)
	txt1:setFillColor(0)
	txt1.alpha = 0
	local txt2 = display.newText("", bg.x, txt1.y+30, "font/NanumSquareB.ttf", 23)
	txt2:setFillColor(0)
	txt2.alpha = 0

    local tapButton = display.newImageRect("image2/click.png", 160, 150) -- 다음 버튼
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
		player_animation:setSequence("talking")
		player_animation:play()
	end

	local function playerSmiling()
		player_animation:setSequence("talking_smile")
		player_animation:play()
	end

	local function playerBlinking()
		player_animation:setSequence("blinking")
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

	local function npcSmiling()
		npc_animation:setSequence("smiling")
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
		print("stage return")
    	composer.setVariable("stageNum",3)
     	composer.gotoScene("stage",{effect="fade",time=2000})
	end
	---------------------------------------------------- 대사 부분 ------------------------------------------------------
	-- 상황 설명이 끝난 후 대사창 보이게 하는 함수 
	local function showChat()
		print("called showChat()")
		transition.to(txtBox, {time=300, alpha=0.9})
	   	transition.fadeIn(tapButton, {time=300})
	    transition.fadeIn(txt, {time=300})
		transition.fadeIn(showNpcName(), {time=300})

		transition.fadeIn(npc_animation, {time=1000}) -- npc 등장 
		npc_animation:play()
		transition.fadeIn(player_animation, {time=1000}) -- player 등장 
		playerBlinkingS()

		txt.x = 250
		txt.text = "제법입니다, 로르. 꽤 어려운 시험이라고 생각했는데..."
		tNum = tNum + 1
	end

	-- 장면 전환 후 상황 설명
	if tNum == 0 then
		txt1.text = "미니게임을 아슬아슬하게 통과한 로르는 노란 펜던트 조각을 돌려받는다."
		txt2.text = "이에 로르의 몸에 다시 노란빛이 돌기 시작한다."
		
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
			npcBlinking()
			playerSmiling()
			hideNpcName()
			showPlayerName()
			txt.x = 228
			txt.text = "감사합니다, 사제님! 소중히 간직하도록 할게요."
		elseif tNum == 3 then
			txt.x = 320
			txt.text = "... 참, 사제님, 혹시... 다른 펜던트 조각은 어디에 있는지 알고 계시나요?"
		elseif tNum == 4 then
			npcTalking()
			playerBlinkingS()
			hidePlayerName()
			showNpcName()
			txt.x = 455
			txt.text = "(고개를 끄덕이며) 빛의 창조주가 서서히 우리의 곁을 떠나기 시작할 때 수많은 동물이 머무는 곳을 찾아가면,\n저녁의 사제와 함께 비로소 당신이 찾는 것을 발견할 수 있을 것입니다."
		elseif tNum == 5 then
			npcBlinking()
			playerTalking()
			hideNpcName()
			showPlayerName()
			txt.x = 150
			txt.text = "으음... 전혀 모르겠는데......"
		elseif tNum == 6 then
			txt.x = 175
			txt.text = "조금 더 알려 주실 수는 없을까요?"
		elseif tNum == 7 then
			npcTalking()
			playerBlinking()
			hidePlayerName()
			showNpcName()
			txt.x = 275
			txt.text = "(단호한 목소리로) 제가 알려드릴 수 있는 건 여기까지입니다."
		elseif tNum == 8 then
			npcBlinking()
			playerSmiling()
			hideNpcName()
			showPlayerName()
			txt.x = 300
			txt.text = "네, 알겠습니다... 우선 수많은 동물이 머무는 곳을 찾아봐야겠어요.\n안녕히 계세요, 사제님!"
		elseif tNum == 9 then
			npcSmiling()
			playerBlinkingS()
			hidePlayerName()
			showNpcName()
			transition.fadeOut(player_animation, {time=1000})
			txt.x = 295
			txt.text = "(멀어져가는 로르를 바라보며) 당신은 반드시 해낼 수 있을 거예요.\n신의 가호가 깃들길......"
			-- 챕터2 end
		elseif tNum > 9 then
		print("tNum>9")
			gotoNextScene()
		end
	end

	-- 대화창에 있는 하단 이미지. 누르면 대화 진행, 대화 종료
    local function tapButtonEvent(event)
    	tNum = tNum + 1
    	txtEvent()
    end

	tapButton:addEventListener("tap", tapButtonEvent)

		sceneGroup:insert(bg)
		sceneGroup:insert(player)
		sceneGroup:insert(npc)
		--npc 애니메이션 추가
		sceneGroup:insert(player_animation)
		sceneGroup:insert(npc_animation)
		sceneGroup:insert(txtBox)
		sceneGroup:insert(line1)
		sceneGroup:insert(line2)
		sceneGroup:insert(tapButton)
		sceneGroup:insert(appearEf)
		sceneGroup:insert(pendant)
		sceneGroup:insert(txt)
		sceneGroup:insert(txt1)
		sceneGroup:insert(txt2)

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
