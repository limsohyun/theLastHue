-----------------------------------------------------------------------------------------
--
-- script2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image2/afternoon_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	----- 노란 조각 나타나게 하기 위한 -----
	local appearEf = display.newImageRect("image2/appear.png", display.contentWidth, display.contentHeight)
	appearEf.x, appearEf.y = bg.x, bg.y
	appearEf.alpha = 0

	local yPiece = display.newImage("image2/yellowpiece.png", bg.x, bg.y)
    yPiece.alpha = 0

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
			frames = { 1, 10, 10, 1, 10, 10, 1, 11, 10, 10 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "talking_smile",
			frames = { 7, 8, 8, 7, 8, 8, 7, 9, 8, 8 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "talking_worried",
			frames = { 3, 4, 4, 3, 4, 4, 3, 5, 4, 4 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "blinking",
			frames = { 10, 10, 10, 10, 11, 10, 10, 10, 10 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
    		name = "blinking_smile",
    		frames = { 7, 7, 7, 7, 9, 7, 7, 7, 7 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "blinking_worried",
    		frames = { 3, 3, 3, 3, 4, 3, 3, 3, 3 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	}
    }
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
    player_animation.alpha = 0

	--- npc 애니메이션 ---
	local sheetOptions = 
	{
		width = 565,
		height = 720,
		numFrames = 3
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
		}
	}
	local npc_animation = display.newSprite(sheet_npc, sequences_npc)
	npc_animation.x, npc_animation.y = 1000, bg.y
	npc_animation.alpha = 0

	---------------
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0.9

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha, line1.alpha = 0, 0

	local npc = display.newText("낮의 사제", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
	npc.alpha, line2.alpha = 0, 0

    local txt = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)

    local tapButton = display.newImageRect("image2/click.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 1

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

	---- player 애니메이션 관련 함수 
	local function playerTalking()
		player_animation:setSequence("talking")
		player_animation:play()
	end

	local function playerTalkingW()
		player_animation:setSequence("talking_worried")
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

	local function playerBlinkingW()
		player_animation:setSequence("blinking_worried")
		player_animation:play()
	end
	
	---- npc 애니메이션 관련 함수
	local function npcTalking()
		npc_animation:setSequence("talking")
		npc_animation:play()
	end

	local function npcBlinking()
		npc_animation:setSequence("blinking")
		npc_animation:play()
	end

	-- 노란 조각이 배경과 함께 서서히 나타나는 효과
	local function effect1()
		transition.to(appearEf, {time=600, delay=400, alpha=0.3})
	    transition.fadeIn(yPiece, {time=600, delay=400})
	end

	-- 노란 조각이 배경과 함께 서서히 사라지는 효과
	local function effect2()
		transition.fadeOut(appearEf, {time=600, delay=400})
	    transition.fadeOut(yPiece, {time=600, delay=400})
	end

	-- 스토리가 끝난 후 게임 스타트 화면으로 이동하는 함수
	local function gotoStart(event)
		sceneGroup:insert(bg)
		sceneGroup:insert(txtBox)
		sceneGroup:insert(txt)
		sceneGroup:insert(player)
		sceneGroup:insert(line1)
		sceneGroup:insert(npc)
		sceneGroup:insert(line2)
		sceneGroup:insert(tapButton)
		sceneGroup:insert(appearEf)
		sceneGroup:insert(yPiece)
		--npc 애니메이션 추가
		sceneGroup:insert(npc_animation)
		sceneGroup:insert(player_animation)

		print("스타트 파일로 이동함")
		composer.removeScene("script2")
	   	composer.gotoScene("game2_start", {effect="fade"})
	end
	
	---------------------------------------------------- 대사 부분 ------------------------------------------------------
	-- 장면 전환 후 처음 대사 나오게
	if tNum == 0 then
		showPlayerName()
		transition.fadeIn(player_animation, {time=1000}) -- player 등장
	 	playerTalking()
		txt.x = 195
		txt.text = "저기... 사제님...?\n(사제의 눈치를 보며 조심히 다가간다.)"
	end

    local function txtEvent()
    	--print("tNum is.."..tNum)
		if tNum == 1 then
			playerBlinking()
			transition.fadeIn(npc_animation, {time=1000}) -- npc 등장 
			npc_animation:play() -- 처음 npc가 말을 할 때 
			hidePlayerName()
			showNpcName()
			txt.x = 210
			txt.text = "무슨 일이신지?\n(여전히 단호한 표정으로 로르와 마주한다.)"
		elseif tNum == 2 then
			npcBlinking()
			playerTalking()
			hideNpcName()
			showPlayerName()
			txt.x = 263
			txt.text = "(점차 기어들어가는 목소리로) 그... 나비를 따라 왔는데..."
		elseif tNum == 3 then
			playerBlinking()
			hidePlayerName()
			showNpcName()
			txt.x = 168
			txt.text = "(아무 말 없이 로르를 바라본다.)"
		elseif tNum == 4 then
			playerTalking()
			hideNpcName()
			showPlayerName()
			txt.x = 267
			txt.text = "사, 사제님...! 제가 노란 빛이 담긴 조각을 찾고 있어요......\n혹시 보신 적 있으신가요?"
		elseif tNum == 5 then
			playerBlinking()
			npcTalking()
			hidePlayerName()
			showNpcName()
			effect1() -- 펜던트 조각 보이기
			txt.x = 173
			txt.text = "이게 맞다면, 네, 가지고 있습니다."
		elseif tNum == 6 then
			npcBlinking()
			playerTalking()
			hideNpcName()
			showPlayerName()
			effect2() -- 펜던트 조각 숨기기
			txt.x = 157
			txt.text = "호, 혹시... 받을 수 있을까요?"
		elseif tNum == 7 then
			playerBlinking()
			npcTalking()
			hidePlayerName()
			showNpcName()
			txt.x = 267
			txt.text = "(고개를 살짝 가로젓는다.) 안타깝게도, 넘겨줄 수 없습니다."
		elseif tNum == 8 then
			npcBlinking()
			playerTalkingW()
			hideNpcName()
			showPlayerName()
			txt.x = 190
			txt.text = "그렇지만... 그게 없다면 저는 평생......"
		elseif tNum == 9 then
			txt.x = 230
			txt.text ="사제님, 정말 돌려받을 수 있는 방법이 없을까요?"
		elseif tNum == 10 then
			playerBlinkingW()
			npcTalking()
			hidePlayerName()
			showNpcName()
			txt.x = 170
			txt.text = "방법이 아주 없는 건... 아닙니다."
		elseif tNum == 11 then
			txt.x = 295
			txt.text = "제가 준비한 시험 하나를 통과하시면... 넘겨드릴 의향도 있습니다."
		elseif tNum == 12 then
			npcBlinking()
			playerTalking()
			hideNpcName()
			showPlayerName()
			txt.x = 85
			txt.text = "!! 정말요?"
		elseif tNum == 13 then
			playerSmiling()
			txt.x = 270
			txt.text = "감, 감사합니다, 사제님! 지금 바로 시험에 응하도록 할게요!"
		elseif tNum > 13 then
			gotoStart()
		end
	end

	-- 대화창에 있는 하단 이미지. 누르면 대화 진행, 대화 종료
    local function tapButtonEvent(event)
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
