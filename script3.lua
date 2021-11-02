-----------------------------------------------------------------------------------------
--
-- script3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image3/evening_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	----- 빨간 조각 나타나게 하기 위한 -----
	local appearEf = display.newImageRect("image3/appear.png", display.contentWidth, display.contentHeight)
	appearEf.x, appearEf.y = bg.x, bg.y
	appearEf.alpha = 0

	local rPiece = display.newImage("image3/redpiece.png", bg.x, bg.y)
    rPiece.alpha = 0

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
    		name = "first",
    		frames = { 1, 1, 1, 1, 1, 1, 1, 2 },
    		time = 1500,
    		loopCount = 1
    	},
    	{
			name = "shocked",
			frames = { 11, 11, 10, 10, 10, 12, 10, 10, 10, 10, 10, 10, 13 },
			time = 1500,
			loopCount = 1
    	},
    	{
			name = "blinking_shocked",
			frames = { 13, 13, 13, 13, 14, 13, 13, 13, 13 },
			time = 1500,
			loopCount = 0
    	},
  		{
			name = "talking",
			frames = { 4, 5, 5, 4, 5, 5, 4, 6, 5, 5 },
			time = 1500,
			loopCount = 0
    	},
    	{
			name = "blinking",
			frames = { 2, 2, 2, 2, 3, 2, 2, 2, 2 },
			time = 1500,
			loopCount = 0
    	},
    	{
			name = "talking_worried",
			frames = { 10, 11, 11, 10, 11, 11, 10, 12, 11, 11 },
			time = 1500,
			loopCount = 0
    	},
    	{
			name = "blinking_worried",
			frames = { 10, 10, 10, 10, 12, 10, 10, 10, 10 },
			time = 1500,
			loopCount = 0
    	},
    	{
    		name = "talking_smiling",
    		frames = { 7, 8, 8, 7, 8, 8, 7, 9, 8, 8 },
    		time = 1500,
    		loopCount = 0,
    	}
    }
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
   	player_animation.alpha = 0

	local pSleep = display.newImageRect(sheet_player, 1, 396, 720)
	pSleep.x, pSleep.y = player_animation.x, player_animation.y
	pSleep.alpha = 0

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
		{
			name = "blinking_sour", 
			frames = { 2, 2, 2, 2, 6, 2, 2 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		}
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
    local txt1 = display.newText("", bg.x, bg.y, "font/NanumSquareB.ttf", 23)
	txt1.alpha = 0

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
		player_animation:setSequence("talking")
		player_animation:play()
	end

	local function playerBlinking()
		player_animation:setSequence("blinking")
		player_animation:play()
	end

	local function playerTalking2()
		player_animation:setSequence("talking_worried")
		player_animation:play()
	end

	local function playerBlinking2()
		player_animation:setSequence("blinking_worried")
		player_animation:play()
	end

	-----
	-- npc 애니메이션 관련 함수
	local function npcTalking()
		npc_animation:setSequence("talking")
		npc_animation:play()
	end

	local function npcBlinking()
		npc_animation:setSequence("blinking")
		npc_animation:play()
	end

	local function npcBlinking2()
		npc_animation:setSequence("blinking_sour")
		npc_animation:play()
	end

	-----

	-- 빨간 조각이 배경과 함께 서서히 나타나는 효과
	local function effect1()
		transition.to(appearEf, {time=600, delay=400, alpha=0.3})
	    transition.fadeIn(rPiece, {time=600, delay=400})
	end

	-- 빨간 조각이 배경과 함께 서서히 사라지는 효과
	local function effect2()
		transition.fadeOut(appearEf, {time=600, delay=400})
	    transition.fadeOut(rPiece, {time=600, delay=400})
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
		sceneGroup:insert(rPiece)
		sceneGroup:insert(txt)
		sceneGroup:insert(txt1)
		--npc 애니메이션 추가
		sceneGroup:insert(player_animation)
		sceneGroup:insert(npc_animation)

		print("stage_temp 파일로 이동함")
		composer.removeScene("script3")
	   	composer.gotoScene("game3_start")
	end
	---------------------------------------------------- 대사 부분 ------------------------------------------------------
	
	-- 상황 설명이 끝난 후 대사창 보이게 하는 함수 
	local function showChat()
		print("called showChat()")
		transition.to(txtBox, {time=300, alpha=0.9})
	    transition.to(tapButton, {time=300, alpha=1})
	    transition.fadeIn(txt, {time=300})
		transition.fadeIn(showPlayerName(), {time=300})
		transition.fadeIn(player_animation, {time=300, delay=400})
		player_animation:setSequence("talking_smiling")
		player_animation:play()

		txt.x = 120
		txt.text = "뭐야, 별거 아니네!"
		tNum = tNum + 1
	end

	-- 장면 전환 후 상황 설명
	if tNum == 0 then
		txt1.text = "더욱 깊은 숲 속으로 들어간지 얼마 지나지 않아 로르는 크고 작은 동물들이 함께 모여 있는 곳을 발견한다."
		transition.fadeIn(txt1, {time=2000, delay=1000})
		transition.fadeOut(txt1, {time=1000, delay=6000})
	    timer.performWithDelay(7000, showChat)
	end

    local function txtEvent()
    	--print("tNum is.."..tNum)
		if tNum == 2 then
			hideNpcName()
			showPlayerName()
			txt.x = 250
			txt.text = "여기서 기다리고 있으면 되는 건가...\n그런데 오늘 낮잠을 못 자서 그런지 졸음이 몰려오네..."
		elseif tNum == 3 then
			player_animation:pause()
			player_animation.alpha = 0
			pSleep.alpha = 1
			txt.x = 340
			txt.text = "(말을 마친 지 얼마 지나지 않아, 로르는 나무에 기대 꾸벅꾸벅 졸기 시작한다.)"
		elseif tNum == 4 then
			hidePlayerName()
			pSleep.alpha, player_animation.alpha = 0, 1
			player_animation:setSequence("first")
			player_animation:play()
			transition.fadeIn(npc_animation, {time=1000}) -- npc 등장
			npcBlinking()
			txt.alpha = 0
			txt1.text = "로르가 달콤한 잠에 빠져 있는 동안, 해는 이미 서쪽을 향해 넘어가며 붉은 빛을 내뿜고 있었다."..
			"\n\n노을이 온 세상을 뒤덮은 지 얼마 지나지 않아, 누군가가 다가와 로르의 볼을 콕콕 찌른다."..
			"\n\n볼에 느껴지는 가벼운 자극에 잠에서 깬 로르는 크게 하품하며 일어난다."
			txt1.size, txt1.alpha = 19, 1
			txt1.x = 400
			txt1.y = txt.y+17
		elseif tNum == 5 then
			showPlayerName()
			playerTalking2()
			txt1.alpha, txt.alpha = 0, 1		
			txt.x = 160
			txt.text = "흐아암...~ ...... 누, 누구세요?"
		elseif tNum == 6 then
			hidePlayerName()
			showNpcName()
			npcBlinking2()
			playerBlinking2()
			txt.x = 347
			txt.text = "그건 내가 묻고 싶은 말인데. 내 동료들이 쉬고 있는 곳에 허락도 없이 찾아오고!"
		elseif tNum == 7 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerTalking2()
			txt.x = 335
			txt.text = "저는 그저... (잠시 무언가를 생각하는듯 싶더니)"..
			"\n빛의 창조주는... 태양, 그리고 태양이 우리를 떠나기 시작하는 시간은 노을..."
		elseif tNum == 8 then
			player_animation:setSequence("shocked")
			player_animation:play()
			txt.x = 195
			txt.text = "... 앗, 그럼 설마 당신이... 저녁의 사제?"
		elseif tNum == 9 then
			hidePlayerName()
			showNpcName()
			npcTalking()
			player_animation:setSequence("blinking_shocked")
			player_animation:play()
			txt.x = 270
			txt.text = "그래~ 이 몸이 바로 저녁을 수호하고 있는 저녁의 사제라고!"
		elseif tNum == 10 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerTalking2()
			txt.x = 223
			txt.text = "그, 그렇군요... 저는 로르라고 해요.\n사제님, 제 펜던트 조각은 어디에 있는 건가요?"
		elseif tNum == 11 then
			hidePlayerName()
			showNpcName()
			effect1() -- show redpiece
			playerBlinking2()
			npcTalking()
			txt.x = 383
			txt.text = "응? 아~ 반짝이는 붉은색 보석 같은 거? (주머니에서 붉은 펜던트 조각을 꺼내 보여준다.)\n아까 늑대가 평야에서 발견했다며 가져다줬어. "
		elseif tNum == 12 then
			hideNpcName()
			showPlayerName()
			effect2() -- hide redpiece
			npcBlinking()
			playerTalking()
			txt.x = 320
			txt.text = "네! 그거 맞아요! 제가 애타게 찾고 있는 물건인데 돌려받을 수 있을까요?"
		elseif tNum == 13 then
			hidePlayerName()
			showNpcName()
			playerBlinking()
			npcTalking()
			txt.x = 408
			txt.text = "어차피 나에겐 쓸모 없는 물건이라 바로 돌려줘도 손해는 아니지만... 이 귀한 걸 그냥 줄 순 없지!\n내 시험을 통과하면 돌려주도록 할게."
		elseif tNum == 14 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerTalking2()
			txt.x = 202
			txt.text = "(작게 한숨을 쉬곤) 으으... 또 시험이구나."
		elseif tNum == 15 then
			hidePlayerName()
			showNpcName()
			playerBlinking2()
			npcBlinking2()
			txt.x = 430
			txt.text = "(눈을 가늘게 뜨며 못마땅한 표정으로 로르를 바라본다.) 방금 뭐라고 했어? 돌려받고 싶지 않은 거야?"
		elseif tNum == 16 then
			hideNpcName()
			showPlayerName()
			npcBlinking()
			playerTalking()
			txt.x = 332
			txt.text = "(허둥대며 급하게 화제를 돌린다.) 아, 아니에요! 지금 당장 시험에 임할게요!"
		elseif tNum > 16 then
			gotoNextScene()
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
