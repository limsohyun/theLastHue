-----------------------------------------------------------------------------------------
--
-- script4.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("image4/night_before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	-- 색을 찾은 뒤에 배경
	local bg2 = display.newImageRect("image4/night_after.png", display.contentWidth, display.contentHeight)
	bg2.x, bg2.y = display.contentWidth/2, display.contentHeight/2
	bg2.alpha = 0

	-- [ Sound : 무언가를 찾아 헤매는듯, 숨가쁘게 달리는 소리. ]
	local backgroundMusic = audio.loadSound("music/breath.mp3")

	-----  펜던트 나타나게 하기 위한 -----
	local appearEf = display.newImageRect("image4/appear.png", display.contentWidth, display.contentHeight)
	appearEf.x, appearEf.y = bg.x, bg.y
	appearEf.alpha = 0

	local pendant = display.newImage("image4/4.png", bg.x, bg.y)
	pendant.alpha = 0

    --- player 애니메이션 --- 수정 필요 
    local sheetOptions1 =
    {
    	width = 396,
    	height = 720,
    	numFrames = 14
    }
    local sheet_player = graphics.newImageSheet("image4/player_sheet4.png", sheetOptions1)

	local sequences_player = {
    	{
    		name = "blinking_shocked",
    		frames = { 1, 1, 1, 1, 2, 1, 1, 1, 1 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "talking_crying",
    		frames = { 3, 3, 3, 2, 3, 3, 3, 2 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "cryNsmile",
    		frames = { 4, 5, 4, 5 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
  		{
			name = "talking_smile",
			frames = { 9, 10, 10, 9, 10, 10, 9, 11, 10, 10 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "blinking",
			frames = { 10, 10, 10, 10, 12, 10, 10, 10, 10 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "blinking_smile",
			frames = { 9, 9, 9, 9, 11, 9, 9, 9, 9 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	}
    }
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
    player_animation.alpha = 0

    --- 플레이어 삽화 ---
    local pIllust = {}
    pIllust[0] = display.newImageRect("image4/final1.png", display.contentWidth, display.contentHeight)
    pIllust[1] = display.newImageRect("image4/final2.png", display.contentWidth, display.contentHeight)
    pIllust[2] = display.newImageRect("image4/final3.png", display.contentWidth, display.contentHeight)
    for i = 0, 2, 1 do
    	pIllust[i].x, pIllust[i].y = bg.x, bg.y
    	pIllust[i].alpha = 0
    end
   
    --- npc 애니메이션 ---
	local sheetOptions = 
	{
		width = 521,
		height = 720,
		numFrames = 3
	}
	local sheet_npc = graphics.newImageSheet("image4/npc4_sheet.png", sheetOptions)

	local sequences_npc = {
		{
			name = "blinking",
			frames = { 1, 1, 1, 1, 3, 1, 1 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		}
	}
	local npc_animation = display.newSprite(sheet_npc, sequences_npc)
	npc_animation.x, npc_animation.y = 1000, bg.y
	npc_animation.alpha = 0
    
    --- 신 ---
	local godUI = display.newImage("image4/god.png", 1000, bg.y)
	godUI.alpha = 0

	---------------
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha, line1.alpha = 0, 0

	local npc = display.newText("밤의 사제", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
	npc.alpha, line2.alpha = 0, 0

	local god = display.newText("신", 60, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line3 = display.newRoundedRect(god.x, god.y+11, 22, 3, 10)
	god.alpha, line3.alpha = 0, 0

	-- 대사
    local txt = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)

    -- 시나리오 스크립트용 
    local txt1 = display.newText("", bg.x, bg.y, "font/NanumSquareB.ttf", 23)
	local txt2 = display.newText("", bg.x, bg.y-30, "font/NanumSquareB.ttf", 23)
	local txt3 = display.newText("", bg.x, txt2.y+30, "font/NanumSquareB.ttf", 23)
	local txt4 = display.newText("", bg.x, txt3.y+30, "font/NanumSquareB.ttf", 23)
	txt1.alpha, txt2.alpha, txt3.alpha, txt4.alpha = 0, 0, 0, 0

    local tapButton = display.newImageRect("image4/click.png", 160, 150)
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

	local function showGodName()
		god.alpha = 1
		line3.alpha = 0.6
	end

	local function hideGodName()
		god.alpha = 0
		line3.alpha = 0
	end

	-- player 애니메이션 관련 함수 
	local function playerTalking()
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

	local function playerBlinkingSh()
		player_animation:setSequence("blinking_shocked")
		player_animation:play()
	end

	local function playerTalkingC()
		player_animation:setSequence("talking_crying")
		player_animation:play()
	end

	local function playerCnS()
		player_animation:setSequence("cryNsmile")
		player_animation:play()
	end

	-- npc 애니메이션 관련 함수
	local function npcBlinking()
		npc_animation:setSequence("blinking")
		npc_animation:play()
	end

	-- 팬던트가 배경과 함께 서서히 나타났다 사라지는 효과
	local function pendantEf()
		transition.to(appearEf, {time=2000, delay=1000, alpha=0.3})
	    transition.fadeIn(pendant, {time=2000, delay=1000})
	    transition.fadeOut(appearEf, {time=1000, delay=6000})
	    transition.fadeOut(pendant, {time=1000, delay=6000})
	end

	-- 다음 화면으로 전환하는 함수
	local function gotoNextScene()
		sceneGroup:insert(bg)
		sceneGroup:insert(bg2)
		sceneGroup:insert(txtBox)
		sceneGroup:insert(txt)
		sceneGroup:insert(player)
		sceneGroup:insert(line1)
		sceneGroup:insert(npc)
		sceneGroup:insert(line2)
		sceneGroup:insert(god)
		sceneGroup:insert(godUI)
		sceneGroup:insert(line3)
		sceneGroup:insert(tapButton)
		sceneGroup:insert(appearEf)
		sceneGroup:insert(pendant)   
		sceneGroup:insert(txt1)
		sceneGroup:insert(txt2)
		sceneGroup:insert(txt3)
		sceneGroup:insert(txt4)
		for i = 0, 2, 1 do sceneGroup:insert(pIllust[i]) end
		sceneGroup:insert(npc_animation)
		sceneGroup:insert(player_animation)

		print("ending 파일로 이동함")
		composer.removeScene("script4")
	   	composer.gotoScene("ending", {effect="fade"})
	end
	---------------------------------------------------- 대사 부분 ------------------------------------------------------
	-- 대사창 보이게 하는
	local function showChat()
		print("called showChat()")
		transition.to(txtBox, {time=300, alpha=0.9})
	   	transition.fadeIn(tapButton, {time=300})

		if tNum == 0 then
			playerBlinkingSh()
			audio.play( backgroundMusic, { loops = 0 } )
			audio.setVolume( 0.1 )

			txt.x = 210
			txt.text = "(가쁜 숨을 고르며) 하아, 하아... 어떡하지..."
		elseif tNum == 2 then
			playerTalkingC()
			txt.x = 495
			txt.text = "(눈물을 뚝뚝 흘리며) 다시는… 다시는… 제가 수행해야할 임무를 소홀히 여기지 않겠어요. 제게 한 번만 기회를 주세요."..
			"\n다시 색깔을 수호하고 싶어요. 색깔을, 그리고 이 세상을 어둠의 세력으로부터 지켜내고 싶어요!"
		elseif tNum == 3 then
			transition.fadeIn(txt1, {time=300})
		    transition.fadeIn(npc_animation, {time=1000})
			transition.fadeIn(player_animation, {time=1000}) -- player 등장 
			npcBlinking()
			playerTalkingC()
		 	txt1.text = "사제가 말없이 손을 내밀자, 로르는 머뭇거리며 자신의 펜던트를 건넨다."
		 	txt1.size, txt1.x, txt1.y = 19, txtBox.x, txtBox.y-27
		end
		
		if tNum ~= 3 and tNum ~= 6 then
			transition.fadeIn(txt, {time=300})
			transition.fadeIn(showPlayerName(), {time=300})
			transition.fadeIn(player_animation, {time=1000}) -- player 등장 
		end
	end

	-- 대사창이 서서히 사라지는
	local function hideChat()
		print("called hideChat()")
		transition.fadeOut(txtBox, {time=300})
	   	transition.fadeOut(tapButton, {time=300})
	    transition.fadeOut(txt, {time=300})
		transition.fadeOut(hidePlayerName(), {time=300})
		transition.fadeOut(player_animation, {time=300})
	end

	-- 펜던트와 텍스트박스가 함께 사라지게 하는
	local function onlyButton()
		transition.fadeIn(tapButton, {time=1000})
		transition.fadeOut(txtBox, {time=1000})
		transition.fadeOut(txt1, {time=1000})
	end

	-- 장면 전환 후 상황 설명
	if tNum == 0 then
		txt2.text = "밤의 사제를 찾으러 떠난 로르."
		txt3.text = "숲을 뛰어다니며 정신없이 그를 찾아 헤매지만, 밤의 사제는 끝내 보이지 않는다."
		txt4.text = "자정이 가까워질수록 로르의 마음은 조급해져만 간다."
		
	   	transition.fadeIn(txt2, {time=2000, delay=1000})
	   	transition.fadeIn(txt3, {time=2000, delay=1000})
	   	transition.fadeIn(txt4, {time=2000, delay=1000})
	    transition.fadeOut(txt2, {time=2000, delay=7000})
	    transition.fadeOut(txt3, {time=2000, delay=7000})
	    transition.fadeOut(txt4, {time=2000, delay=7000})
	    timer.performWithDelay(9000, showChat)
	end

    local function txtEvent()
    	print("tNum is.."..tNum)
		if tNum == 1 then
			txt.x = 175
			txt.text = "여전히 밤의 사제는 보이지 않아..."
		elseif tNum == 2 then
			hideChat()
			txt2.text = "자정까지는 채 10분도 남지 않은 상황."
			txt3.text = "결국 로르는 모든 것을 포기한듯 눈을 꼭 감은 채 진심 어린 목소리로 숲을 향해 소리친다."
			transition.fadeIn(txt2, {time=2000, delay=1000})
			transition.fadeIn(txt3, {time=2000, delay=1000})
			transition.fadeOut(txt2, {time=1000, delay=6000})
			transition.fadeOut(txt3, {time=1000, delay=6000})
			timer.performWithDelay(8000, showChat)
		elseif tNum == 3 then
			txt.alpha = 0
			hideChat()
			transition.fadeIn(pIllust[0], {time=2000}) -- 삽화 1
			txt2.text = "이때, 로르의 가슴에서 파랑, 빨강, 노랑이 섞이며 천천히, 밝게 빛난다."
			txt3.text = "로르가 자신의 심장에서 흘러나온 빛을 따라 위로 올려다보자, 어느샌가 조용히 다가온 밤의 사제를 마주하게 된다."
			txt2.y = 650
			txt3.y = txt2.y+30	
		   	transition.fadeIn(txt2, {time=1000, delay=2000})
		   	transition.fadeIn(txt3, {time=1000, delay=2000})
		    transition.fadeOut(txt2, {time=1000, delay=9000})
		    transition.fadeOut(txt3, {time=1000, delay=9000})
		    transition.fadeOut(pIllust[0], {time=2000, delay=9000})
		    timer.performWithDelay(11000, showChat)
		elseif tNum == 4 then
			transition.fadeOut(player_animation, {time=800})
		    transition.fadeOut(npc_animation, {time=800})
			tapButton.alpha = 0
			txt1.text = "밤의 사제의 손에 펜던트가 닿는 순간, 펜던트가 빛나기 시작하여 펜던트 테두리의 검은색이 돌아온다."
			transition.fadeIn(bg2, {time=5000})
			pendantEf()
		    timer.performWithDelay(6000, onlyButton)
		elseif tNum == 5 then
			bg.alpha = 0 -- 색 찾기 전 백그라운드 안 보이게
			tapButton.alpha = 0
			transition.fadeIn(pIllust[1], {time=1000}) -- 삽화 2
			transition.fadeIn(pIllust[2], {time=3000, delay=3000}) -- 삽화 3

			txt2.y = 40
			txt3.y = txt2.y+30
			txt2.text = "펜던트의 테두리까지 색깔이 완벽히 돌아오자, 로르의 눈동자가 투명하게 빛나는 검은색으로 돌아온다."
			txt3.text = "밤의 사제는 로르에게 말없이 펜던트를 다시 건네고는 로르에게서 흘러나온 빛과 함께 어둠 속으로 사라진다."
			transition.fadeIn(txt2, {time=1000, delay=1000})
		   	transition.fadeIn(txt3, {time=1000, delay=1000})
		    transition.fadeOut(txt2, {time=1000, delay=9000})
		    transition.fadeOut(txt3, {time=1000, delay=9000})
		    transition.fadeIn(tapButton, {time=1000, delay=9000})
		elseif tNum == 6 then
			pIllust[1].alpha = 0
			transition.fadeOut(pIllust[2], {time=1000})
			timer.performWithDelay(700, showChat)
			transition.fadeIn(txt1, {time=300, delay=700})
			txt1.text = "이 모든 상황을 멀리서 지켜보던 신이 로르를 향해 천천히 걸어온다."
		elseif tNum == 7 then
			transition.fadeIn(player_animation, {time=1000}) -- player 등장 
			transition.fadeIn(godUI, {time=1000}) -- 신 등장
			playerCnS()
			showPlayerName()
			txt1.alpha, txt.alpha = 0, 1
			txt.x = 327
			txt.text = "(그 어느 때보다 행복한 미소가 가득 담긴 얼굴로 흘러내린 눈물을 닦는다.)\n...... ! 아... 드디어 돌아왔어! 감사합니다, 신님!"
		elseif tNum == 8 then
			playerBlinkingS()
			hidePlayerName()
			showGodName()
			txt.x = 118
			txt.text ="로르, 수고 많았다."
		elseif tNum == 9 then
			showPlayerName()
			hideGodName()
			playerTalking()
			txt.x = 387
			txt.text = "그런데 이게 어떻게 된 일인가요? 밤의 사제는 일반적인 방법으로는 볼 수 없다고 했는데..."
		elseif tNum == 10 then
			playerBlinking()
			hidePlayerName()
			showGodName()
			txt.x, txt.y = 500, txt.y+23
			txt.text = "그래, 밤의 사제는 일반적인 방법으론 볼 수 없지.\n\n허나 이 세상의 모든 색상을 보호하고자 하는 마음,\n다시 말해 자신의 이익은 전혀 바라지 않으며 오로지 타인만을 위하는 마음이 네 순수한 마음이 내면의 빛을 일깨웠구나."
		elseif tNum == 11 then
			showPlayerName()
			hideGodName()
			playerTalking()
			txt.x, txt.y = 307, txtBox.y-45
			txt.text = "(기쁜 표정으로) 정말요? 그래서 밤의 사제를 만날 수 있었던 거구나...\n모든 색깔을 다시 찾게 되어서 정말 다행이에요. "
		elseif tNum == 12 then
			playerBlinkingS()
			hidePlayerName()
			showGodName()
			txt.x = 148
			txt.text = "(말 없이 고개를 끄덕인다.)"
		elseif tNum == 13 then
			showPlayerName()
			hideGodName()
			playerTalking()
			txt.x = 508
			txt.text = "그리고… 저, 이제 다짐했어요. 다시는 색깔을 잃어버리지 않도록 이 펜던트를 그 누구보다 열심히, 성실히 수호하겠다고요."
		elseif tNum == 14 then
			txt.x, txt.y = 515, txt.y+23
			txt.text = "이번엔 사제님들이 도와주셔서 쉽게 찾을 수 있었지만,\n\n만약 사제님이 아닌 어둠의 세력에게 펜던트 조각이 들어갔다면... 우리는 평생 무채색의 세상에서 살아가야 했을지도 몰라요."..
			"\n오늘 다짐한 것처럼 이 세상의 모든 색깔이 그 찬란한 빛을 잃지 않도록, 영원히 수호할게요."
		elseif tNum > 14 then
			local endTxt1 = display.newText("", bg.x, bg.y-30, "font/NanumSquareB.ttf", 23)
			local endTxt2 = display.newText("", bg.x, endTxt1.y+30, "font/NanumSquareB.ttf", 23)
			endTxt1.alpha, endTxt2.alpha = 0, 0

			endTxt1.text = "이후 로르는 다시 색채의 수호자가 되어, 항상 펜던트를 소중히 보호하며 그 누구보다 성실하게 살아간다."
			endTxt2.text = "우리가 숨을 쉬는 이 세상이 무채색이 아닌 아름다운 오색빛으로 찬란하게 빛나는 이유도 로르가 수호하고 있기 때문이라고."
	
  		 	transition.fadeIn(endTxt1, {time=2000, delay=1000})
   			transition.fadeIn(endTxt2, {time=2000, delay=1000})
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
