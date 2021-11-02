-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local backgroundMusic = audio.loadSound("music/bird.mp3")

	audio.play( backgroundMusic, { fadeIn = 2000, duration = 20000 } )

	local bg = display.newImageRect( "image1/before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2
	
    local naration = display.newText(" ", display.contentWidth/2, display.contentHeight/2, "font/NanumSquareR.ttf", 25)
	naration:setFillColor( 0 )
	naration.alpha = 0

	local naration2 = display.newText(" ", display.contentWidth/2, display.contentHeight/2, "font/NanumSquareR.ttf", 25)
	naration2:setFillColor( 0 )
	naration2.alpha = 0

	local god = display.newImageRect( "image1/god.png", display.contentHeight - 100, display.contentHeight- 350)
	god.x, god.y = display.contentWidth/2 - 350, display.contentHeight/2 - 150
	god.alpha = 0

	--- player 애니메이션 ---
    local sheetOptions =
    {
    	width = 395.9,
    	height = 720,
    	numFrames = 14
    }
    local sheet_player = graphics.newImageSheet("image1/lor_sheet.png", sheetOptions)

	local sequences_player = {
    	{
    		name = "crying", 
    		frames = { 2, 2, 2, 2, 1, 1, 2 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "talk_sad",
    		frames = { 7, 9, 9, 9, 9, 8, 7, 7, 9, 9, 9 },
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
  		{
			name = "talk_smile", 
			frames = { 5, 5, 5, 6,6, 5, 5 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "sad",
			frames = {3,3,4,4,4, 3,3,4,4,4,},
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "stay",
			frames = { 9, 9, 10, 10, 10, 9, 10, 10 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	}
    }
    
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = display.contentWidth/2 - 500, display.contentHeight/2 +100
    player_animation.alpha = 0

    	-- player 애니메이션 관련 함수 
	local function playerCrying()
		player_animation:setSequence("crying")
		player_animation:play()
	end

	local function playerTalk_sad()
		player_animation:setSequence("talk_sad")
		player_animation:play()
	end

	local function playerTalk_smile()
		player_animation:setSequence("talk_smile")
		player_animation:play()
	end

	local function playerSad()
		player_animation:setSequence("sad")
		player_animation:play()
	end

	local function playerStay()
		player_animation:setSequence("stay")
		player_animation:play()
	end

	local function mainH()
		transition.to(player_animation, {time=600, delay=400, alpha=0})
	end

	--- npc 애니메이션 -------------------
	local sheetOptions2 = 
	{
		width = 682.5,
		height = 720,
		numFrames = 4
	}
	local sheet_npc = graphics.newImageSheet("image1/npcAll.png", sheetOptions2)

	local sequences_npc = {
		{
			name = "talking",
			frames = { 2, 2, 2, 4, 2, 2, 2},
			time = 1500,
			loopCount = 0, 
			loopDirection = "loop"
		},
		{
			name = "blinking",
			frames = { 1, 1, 4, 1 },
			time = 1500,
			loopCount = 0, 
			loopDirection = "loop"
		},
		{
			name = "smile",
			frames = { 1, 3, 3, 3, 1 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
		}
	}
	local npc_animation = display.newSprite(sheet_npc, sequences_npc)
	npc_animation.x, npc_animation.y = 1000, bg.y
	npc_animation.alpha = 0

	local function npcTalking()
		npc_animation:setSequence("talking")
		npc_animation:play()
	end

	local function npcBlinking()
		npc_animation:setSequence("blinking")
		npc_animation:play()
	end

	local function npcSmile()
		npc_animation:setSequence("smile")
		npc_animation:play()
	end

	local function npcS()
	    transition.to(npc_animation, {time=600, alpha=1})
	end

	local function npcH()
	    transition.to(npc_animation, {time=600, delay=400, alpha=0})
	end
	
	-------------------------------------------------------

	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0)
	txtBox.alpha = 0

	local balloontext = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
	balloontext:setFillColor(1)
	balloontext.alpha = 0

	local boxText = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
	boxText:setFillColor(1)
	boxText.alpha = 0

	local highLight = display.newImageRect( "image1/light.png", display.contentWidth, display.contentHeight)
	highLight.x, highLight.y = display.contentWidth/2, display.contentHeight/2
	highLight.alpha = 0

	local blue = display.newImageRect("image1/blue.png", bg.x, bg.x)
	blue.x, blue.y = display.contentWidth/2, display.contentHeight/2
	blue.alpha = 0

	local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
    player.alpha = 0
    line1.alpha = 0

    local npc = display.newText("아침 사제", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
    npc.alpha = 0
    line2.alpha = 0

    local tapButton = display.newImageRect("image1/button.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 1

    local function showPlayer()
      player.alpha = 1
      line1.alpha = 0.6
      boxText.alpha = 1
   end

   local function showNpc()
      npc.alpha = 1
     line2.alpha = 0.6
     balloontext.alpha = 1
   end

   local function hidePlayer()
      player.alpha = 0
      line1.alpha = 0
      boxText.alpha = 0
   end

   local function hideNpc()
      npc.alpha = 0
      line2.alpha = 0
      balloontext.alpha = 0
   end

	local function nextScene (event)
		composer.removeScene("script1")
	   	composer.gotoScene("game1_start")

	   	sceneGroup:insert(bg)
	   	sceneGroup:insert(txtBox)
	   	sceneGroup:insert(balloontext)
	   	sceneGroup:insert(boxText)
	   	sceneGroup:insert(player)
	   	sceneGroup:insert(npc)
	   	sceneGroup:insert(god)
	   	sceneGroup:insert(line1)
	   	sceneGroup:insert(line2)
	   	sceneGroup:insert(naration)
	   	sceneGroup:insert(naration2)
	   	sceneGroup:insert(player_animation)
        sceneGroup:insert(npc_animation)
        sceneGroup:insert(blue)
        sceneGroup:insert(highLight)
		sceneGroup:insert(tapButton)
	end

	local click = 0
	local function tab_text_change( ... )
		click = click + 1
		if click == 1 then
			naration.text = "따스한 햇살이 내리쬐는 아침, \n\t\t\t\t색깔을 찾기 위해 여정을 떠난 로르는 숲 속 깊은 곳까지 들어간다. "
			transition.fadeIn(naration, { time=1000 })
		elseif click == 2 then
			naration.alpha = 0
			naration.text = " "
			naration2.text = "어떠한 단서도 없이 한참동안 숲 속을 헤매던 로르는 너무나도 지친 나머지, \n결국 그 자리에 서서 닭똥 같은 눈물을 하염없이 흘리고 만다."
			transition.fadeIn(naration2, { time=1000 })
		elseif click == 3 then
			naration2.alpha = 0
			naration2.text = " "
			audio.pause(backgroundMusic)
			showPlayer()
	    	transition.to(player_animation, {time=600, delay=400, alpha=1})
			playerCrying()
			txtBox.alpha = 0.9
			boxText.x = 255
			transition.fadeIn(txtBox, { time=2000 })
			boxText.text = "나, 어떡하면 좋지? 어디로 가야 할지 도저히 모르겠어."
		elseif click == 4 then
			boxText.x = 150
			boxText.text = "아아, 누가 도와줬으면…."

		elseif click == 5 then
			hidePlayer()
			mainH()
		elseif click == 6 then
			boxText.x = txtBox.x
			transition.fadeIn(god, { time=2000 })
			transition.fadeIn(txtBox, { time=2000 })
			boxText.alpha = 1
			boxText.text = "멀리서 로르를 지켜보고 있던 신은, 그런 로르를 딱하게 여기며 아침의 사제에게 조용히 지시를 내린다."
		elseif click == 7 then
			transition.fadeOut(boxText, { time=500 })
		elseif click == 8 then
			transition.blink(god, { time=2000, loops = 1})
			npcS()
			showNpc()
			npc_animation:play()
			npcTalking()
			balloontext.x = 110
			balloontext.text = "…네, 알겠습니다."
		elseif click == 9 then
			transition.moveTo( god, { x=display.contentWidth/2 - 1000, y = bg.y-1000, time=2000 ,delay = 1000} )
			hideNpc()
			npcH()
		elseif click == 10 then
			transition.fadeOut(txtBox, {time = 500})
		elseif click == 11 then
			txtBox.alpha = 0.9
			bg.alpha = 0
			playerTalk_sad()
			showPlayer()
			transition.fadeIn(bg, {time = 2000})
			boxText.x = 95
			transition.to(player_animation, {time=600, delay=400, alpha=1})
			playerTalk_sad()
			boxText.text = "당신은……?"
		elseif click == 12 then
			balloontext.text = "안녕하세요, 로르. 저는 아침을 수호하는 사제입니다. "
			hidePlayer()
			playerStay()
			transition.fadeIn(npcBlink, {time = 1000})
	        --mainH()
	        npcS()
	        balloontext.x = 250
	        npcBlinking()
		elseif click == 13 then
			npc_animation:play()
			npcTalking()
			showNpc()
		elseif click == 14 then
			balloontext.x = 500
			balloontext.text = "방금 숲 속에서 파란 빛을 내뿜는 작은 조각을 주웠는데, 빛이 향하는 곳을 따라 걷다 보니 로르 앞에 도착하게 되었네요. "
		elseif click == 15 then
			balloontext.x = 155
			balloontext.text = "혹시… 이걸 찾고 계셨나요?"
			transition.to(highLight, {time=600, delay=400, alpha=0.3})
	    	transition.to(blue, {time=600, delay=400, alpha=1})
		elseif click == 16 then
			npcBlinking()
			hideNpc()
			showPlayer()
			playerTalk_smile()
			boxText.x = 265
			boxText.text = "네! 제가 찾던 펜던트 조각이에요! 정말, 정말 감사합니다!"
			transition.to(highLight, {time=600, delay=400, alpha=0})
	   		transition.to(blue, {time=600, delay=400, alpha=0})
		elseif click == 17 then
			hidePlayer()
			showNpc()
			playerStay()
			npcTalking()
			balloontext.x = 300
			balloontext.text = "이것이 아주 귀한 물건임을 알고 있기 때문에, 그냥 드릴 순 없어요."
		elseif click == 18 then
			npcBlinking()
			hideNpc()
			playerTalk_sad()
			boxText.x = 315
			boxText.text = "…그러면 제가 어떻게 해야 하나요? 전 가진 것 하나 없는 요정인데……"
			showPlayer()
		elseif click == 19 then
			playerStay()
			hidePlayer()
			showNpc()
			npcTalking()
			balloontext.x = 370
			balloontext.text = "물질적인 대가는 괜찮습니다. 다만 제가 준비한 시험을 통과하시면 드리도록 할게요."
		elseif click == 20 then
			balloontext.x = 100
			balloontext.text = "어떠신가요?"
		elseif click == 21 then
			npcBlinking()
			playerTalk_smile()
			hideNpc()
			npcSmile()
			boxText.x = 155
			boxText.text = "시험…? 네, 바로 임할게요!"
			showPlayer()
		elseif click == 22 then
			hidePlayer()
			player_animation.alpha = 0
			npc_animation.alpha = 0
		else
			nextScene()
		end
	end
	
	tapButton:addEventListener("tap",tab_text_change) 
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