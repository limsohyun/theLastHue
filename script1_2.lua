-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect( "image1/after.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local highLight = display.newImageRect( "image1/light.png", display.contentWidth, display.contentHeight)
	highLight.x, highLight.y = display.contentWidth/2, display.contentHeight/2
	highLight.alpha = 0

	local blue = display.newImageRect( "image1/blue.png", bg.x - 100, bg.x - 100)
	blue.x, blue.y = display.contentWidth/2, display.contentHeight/2
	blue.alpha = 0
	transition.fadeIn(blue, {time = 1000})

    --- player 애니메이션 ---
    local sheetOptions =
    {
    	width = 395.9,
    	height = 720,
    	numFrames = 17
    }
    local sheet_player = graphics.newImageSheet("image1/lor_sheet2.png", sheetOptions)

	local sequences_player = {
    	{
    		name = "smiling",
    		frames = { 8,8, 9,9, 9},
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "talking",
    		frames = { 7, 7, 8, 7,7, 8,7},
    		time = 1500,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
  		{
			name = "thingking",
			frames = { 10, 10, 11, 11, 11, 11, 10},
			time = 3300,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "surprising",
			frames = {1, 1, 1, 2, 1, 1},
			time = 3300,
			loopCount = 0,
			loopDirection = "loop"
    	},
    	{
			name = "tired",
			frames = {3, 3, 3, 5, 3, 3},
			time = 1500,
    		loopCount = 0,
			loopDirection = "loop"
    	}
    }
    
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = display.contentWidth/2 - 500, display.contentHeight/2 +100
    player_animation.alpha = 0

    	-- player 애니메이션 관련 함수 
	local function playerSmiling()
		player_animation:setSequence("smiling")
		player_animation:play()
	end

	local function playerTalking()
		player_animation:setSequence("talking")
		player_animation:play()
	end

	local function playerThinking()
		player_animation:setSequence("thingking")
		player_animation:play()
	end

	local function playerSurprising()
		player_animation:setSequence("surprising")
		player_animation:play()
	end

	local function playerTired()
		player_animation:setSequence("tired")
		player_animation:play()
	end


	local function mainS()
		transition.to(player_animation, {time=600, delay=400, alpha=1})
	end

	local function mainH()
		transition.to(player_animation, {time=600, delay=400, alpha=0})
	end

    ----------npc
	--- npc 애니메이션 ---
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
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
		{
			name = "blinking",
			frames = { 1, 1, 4, 1 },
			time = 1500,
			loopCount = 0, -- 무한대
			loopDirection = "loop"
		},
		{
			name = "smile",
			frames = { 1, 3, 3, 3, 1 },
			time = 1500,
			loopCount = 0, -- 무한대
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

	-- npc가 서서히 사라지는 효과
	local function npcH()
	    transition.to(npc_animation, {time=600, delay=400, alpha=0})
	end
	
	-------------------------------------------------------

	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0)
	txtBox.alpha = 0.9
	
	local balloontext = display.newText("", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
	balloontext:setFillColor( 1 )
	balloontext.alpha = 0

	local boxText = display.newText(" ", txtBox.x, txtBox.y-45, "font/NanumSquareR.ttf", 19)
	boxText:setFillColor( 1 )
	boxText.alpha = 0

	local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
    player.alpha = 1
    line1.alpha = 1

    local npc = display.newText("아침 사제", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
    npc.alpha = 0
    line2.alpha = 0

    local naration = display.newText("숲 속 깊은 곳으로 무작정 들어가던 로르는, 잠시 멈추곤 아침의 사제가 남긴 말을 곱씹어본다.", display.contentWidth/2, display.contentHeight/2, "font/NanumSquareB.ttf", 22)
	naration:setFillColor( 0 )
	naration.alpha = 0

    local butterfly = display.newImageRect( "image1/butterfly.png", 300, 300)
	butterfly.x, butterfly.y = display.contentWidth/2 + 300, display.contentHeight/2 - 200
	butterfly.alpha = 0

	local highLight = display.newImageRect( "image1/light.png", display.contentWidth, display.contentHeight)
	highLight.x, highLight.y = display.contentWidth/2, display.contentHeight/2
	highLight.alpha = 0.3

    local tapButton = display.newImageRect("image1/button.png", 160, 150) -- 다음 버튼
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 1

    local function startGame(event)
		composer.removeScene("script1_2")
    	composer.setVariable("stageNum",2)
    	
	   	sceneGroup:insert(bg)
	   	sceneGroup:insert(txtBox)
	   	sceneGroup:insert(boxText)
	   	sceneGroup:insert(player)
	   	sceneGroup:insert(balloontext)
	   	sceneGroup:insert(npc)
	   	sceneGroup:insert(line2)
	   	sceneGroup:insert(line1)
	   	sceneGroup:insert(player_animation)
	   	sceneGroup:insert(npc_animation)
	   	sceneGroup:insert(blue)
	   	sceneGroup:insert(highLight)
	   	sceneGroup:insert(naration)
	   	sceneGroup:insert(butterfly)	
	   	sceneGroup:insert(highLight)
		sceneGroup:insert(tapButton)	

     	composer.gotoScene("stage", {effect="fade",time=2000})
	end

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

	local text = 0
	local function tab_text_change( ... )
		-- body
		text = text + 1
		if text == 1 then
			mainS()
			playerTalking()
			transition.fadeOut(highLight, {time = 1000, delay = 200})
			transition.fadeOut(naration, {time = 1000, delay = 200})
			transition.moveTo( blue, { x=display.contentWidth/2 - 350, y = bg.y+250, time=200 ,delay = 1000} )
			showPlayer()
			boxText.x = 120
			boxText.text = "감사합니다, 사제님!"
			npcS()
			npcSmile()
		elseif text == 2 then
			hidePlayer()
			blue.alpha = 0
			playerSmiling()
			showNpc()
			npc_animation:play()
			npcTalking()
			balloontext.x = 260
			balloontext.text = "아니에요. 아, 그리고 한 가지 더 말씀드릴 것이 있는데… "
		elseif text == 3 then
			balloontext.x = 230
			balloontext.text = "혹시 노란색 조각의 행방이 궁금하지 않으신가요?"
		elseif text == 4 then
			playerTalking()
			hideNpc()
			npcBlinking()
			showPlayer()
			boxText.x = 80
			boxText.text = "궁금해요!"
		elseif text == 5 then
			playerSurprising()
			hidePlayer()
			showNpc()
			npcTalking()
			balloontext.x = 540
			balloontext.text = "당신을 따라다니는 어둠이 사라지다 못해 그대와 하나가 될 때, 나비들이 향하는 곳을 찾아간다면 원하는 답을 얻을 수 있을 거예요."
		elseif text == 6 then
			balloontext.x = 303
			balloontext.text = "그리고… 잊지 마세요, 로르. 스스로 돕는 자만이 하늘도 돕는답니다."
		elseif text == 7 then
			hideNpc()
			mainH()
			npcH()
			transition.fadeOut(txtBox, {time=600, delay=400})			
		elseif text == 8 then
			bg.alpha = 0
			transition.fadeIn(bg, {time = 2000})
			naration.alpha = 1
		elseif text == 9 then
	        transition.fadeOut (naration, { time=2000})
			transition.fadeIn(txtBox, { time=3000 })
			transition.fadeIn(boxText, { time=3000 })
			showPlayer()
			mainS()
			playerTired()
		elseif text == 10 then
			txtBox.alpha = 0.9
			boxText.x = 450
			boxText.text = "으으… 이렇게 무작정 전진만 하다간 오늘 안에 색깔을 전부 되찾지 못하고 말 거야. 침착하게 생각해보자. "
		elseif text == 11 then
			playerThinking()
			boxText.x = 330
			boxText.text = "나를 따라다니는 어둠이 나와 하나가 될 때, 나비를 따라가면 된다고 했지…"
		elseif text == 12 then
			boxText.x = 360
			boxText.text = "(생각에 잠긴 듯 골똘히 생각하다가, 문득 자신의 발 밑에 있는 그림자를 발견한다.) "
		elseif text == 13 then
			boxText.x = 110
			boxText.text = "어둠… 그림자… "
		elseif text == 14 then
			playerSurprising()
			boxText.x = 370
			boxText.text = "아! 설마 그림자와 내가 하나가 되는 시간이라는 건가? …그래, 정오를 뜻하는 거구나!"
		elseif text == 15 then
			boxText.x= 190
			boxText.text = "그치만 정오까진 얼마 안 남았는데…!"
		elseif text == 16 then
			hidePlayer()
			txtBox.alpha = 0
			playerTired()
			transition.fadeIn(butterfly, {time = 2000})
			naration.text = "로르가 걱정스러운 얼굴로 발을 동동 구르고 있는 사이, 멀리서 작은 나비떼가 날아간다."
			transition.fadeIn(naration, {time = 2000})
		elseif text == 17 then
			playerSurprising()
			transition.to(player_animation, {time=600, delay=400, alpha=1})
			transition.fadeOut(naration, {time = 1000})
			txtBox.alpha = 1
			showPlayer()
			boxText.x = 200
			boxText.text = "앗, 혹시 저 나비를 따라가면 되는 건가?"
		elseif text == 18 then
			boxText.x = txtBox.x
			naration.text = " "
			boxText.text = "(허둥대며 나비가 향하는 곳으로 급하게 달려간다.)"
			transition.moveTo( butterfly, { x=display.contentWidth/2 + 1000 , y=display.contentHeight/2 - 300, time=2000 } )
			transition.moveTo( player_animation, { x=display.contentWidth/2 + 800 , y=display.contentHeight/2 +150, time=1000 ,delay = 1000} )
			transition.fadeOut( player_animation, {time=4000, delay = 800} )
		elseif text == 19 then
			naration.text = " "
			hidePlayer()
			transition.fadeOut(txtBox, { time=3000 })
			transition.fadeOut(player_animation, { time=3000 })
			transition.fadeOut(boxText, { time=3000 })
		else
			print("다음씬으로 넘어감")
			startGame()
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