local composer = require( "composer" )
local scene = composer.newScene()
local stageNum=composer.getVariable("stageNum")

function scene:create( event )
	local sceneGroup = self.view
	local stageNum=1

	local bg = display.newImageRect( "image/bg4.png", display.contentWidth,display.contentHeight)
    bg.x = display.contentWidth/2
    bg.y = display.contentHeight/2

	local bg1= display.newImageRect( "image/bg1.png", display.contentWidth,display.contentHeight)
    bg1.x = display.contentWidth/2
    bg1.y = display.contentHeight/2
	bg1.alpha=0

	local blue = display.newImage( "image/blue.png", 150,150)
    blue.x = display.contentWidth/2
    blue.y = display.contentHeight/2
	blue.width=250
	blue.height=250
    blue.alpha=0

    local yellow = display.newImage( "image/yellow.png", 150,150)
    yellow.x = display.contentWidth/2
    yellow.y = display.contentHeight/2
	yellow.width=250
	yellow.height=250
    yellow.alpha=0
    local red = display.newImage( "image/red.png", 150,150)
    red.x = display.contentWidth/2
    red.y = display.contentHeight/2
	red.width=250
	red.height=250
    red.alpha=0

	local black= display.newImage( "image/black.png",150,150)
    black.x = display.contentWidth/2
    black.y = display.contentHeight/2
	black.width=250
	black.height=250
    black.alpha=0

--로딩
local sheetOptions =
{
    width = 720,
    height = 720,
    numFrames = 5,
}

local sequences_pendant = {
    -- consecutive frames sequence
    {
        name = "fall",
    	frames = { 5,5,5,5,4,4,4,4,4,3,3,3,3,3,2,2,2,2,2,1,1,1,1,1 },
        time = 1500,
        loopCount = 1,
        loopDirection = "loop"
    },
        {
        name = "first",
        start = 1,
        count = 5,
        time = 5000,
        loopCount = 0,
        loopDirection = "loop"
    }
}

local sheet_pendant = graphics.newImageSheet( "image/pendant.png", sheetOptions )
local pendant = display.newSprite( sheet_pendant, sequences_pendant)
pendant.x,pendant.y =display.contentWidth/2 , display.contentHeight/2	
pendant.xScale , pendant.yScale=0.4,0.4
 pendant.alpha=0

     --- player 애니메이션 ---
    local sheetOptions =
    {
    	width = 396,
    	height = 720,
    	numFrames = 12
    }
	 local sheetOptions1 =
    {
    	width = 396,
    	height = 720,
    	numFrames = 8
    }
    local sheet_player = graphics.newImageSheet("image/playerSheet0.png", sheetOptions)
	local sheet_player1=graphics.newImageSheet("image/playerSheet3.png", sheetOptions1)
	local sequences_player={
			{name = "first", -- blinking
    		frames = {8,9,10},
    		time = 4000,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "boring", -- blinking
    		frames = {6,6,6,6,7,7,7,7,7,7,7,7,12,12,12},
    		time = 3000,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
    	{
    		name = "confusing", 
    		frames = {6,6,6,6,6,6,6,6,2,2,2,2,1,1,1,1,1,1,1,1,1,1},
    		time = 3000,
    		loopCount = 0,
    		loopDirection = "loop"
    	},
  		{
			name = "despairing",
			frames = { 1 },
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	}
	}
	local sequences_player1 = {
    	
		 {
			name = "despairingWithoutColor", 
			frames = { 2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1,1,1,1,1,1 },
			time = 3000,
			loopCount = 0,
			loopDirection = "loop"
    	},
		 {
			name = "confusingWithoutColor", 
			frames = { 2,2,2,2,2,2,2,3,3,3,3,3,2,2,2,2,2,2},
			time = 3000,
			loopCount = 0,
			loopDirection = "loop"
    	},
		{
			name = "last", 
			frames = { 8,8,8,8,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4},
			time = 1500,
			loopCount = 0,
			loopDirection = "loop"
    	}
    }
    
    local player_animation = display.newSprite(sheet_player, sequences_player)
    player_animation.x, player_animation.y = 200, bg.y
    player_animation.alpha = 0

	  local player_animation1 = display.newSprite(sheet_player1, sequences_player1)
    player_animation1.x, player_animation1.y = 200, bg.y
    player_animation1.alpha = 0

	--- npc 애니메이션 ---

	local npc_animation = display.newImage("image/npcSheet.png", display.contentWidth/3, display.contentHeight/3)
	npc_animation.x, npc_animation.y = 1000, bg.y
	npc_animation.alpha = 0

	---------------
		-- pendant 애니메이션 관련 함수
	local function pendantFall()
		pendant.y=100
		transition.to(pendant, {y=display.contentHeight/2,time=1000, delay=400})
		pendant:setSequence("fall")
		pendant:play()
	end	
		-- player 애니메이션 관련 함수 
	local function playerBoring()
		player_animation.alpha=1
		player_animation:setSequence("boring")
		player_animation:play()
	end	
	local function playerConfusing()
		player_animation.alpha=1
		player_animation:setSequence("confusing")
		player_animation:play()
	end

	local function playerDespairing()
		player_animation.alpha=1
		player_animation:setSequence("despairing")
		player_animation:play()
	end
	
	local function playerDespairingWithoutColor()
		player_animation.alpha=0
		player_animation1.alpha=1
		player_animation1:setSequence("despairingWithoutColor")
		player_animation1:play()
	end

	local function playerDespairingWithoutColor()
		player_animation.alpha=0
		player_animation1.alpha=1
		player_animation1:setSequence("despairingWithoutColor")
		player_animation1:play()
	end
	local function playerConfusingWithoutColor()
		player_animation.alpha=0
		player_animation1.alpha=1
		player_animation1:setSequence("confusingWithoutColor")
		player_animation1:play()
	end
	local function playerLast()
		player_animation.alpha=0
		player_animation1.alpha=1
		player_animation1:setSequence("last")
		player_animation1:play()
	end

	-----

	-- npc가 서서히 나타나는 효과
	local function flash1()
	    transition.to(npc_animation, {time=600, delay=400, alpha=1})
	end

	-- npc가 서서히 사라지는 효과
	local function flash2()
	    transition.to(npc_animation, {time=600, delay=400, alpha=0})
	end


 	---------------
	local txtBox = display.newRect(bg.x, 650, 1280, 250)
	txtBox:setFillColor(0) 
	txtBox.alpha = 0.9

    local player = display.newText("로르", 70, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line1 = display.newRoundedRect(player.x, player.y+11, 50, 3, 10)
	player.alpha = 0
	line1.alpha = 0

	local npc = display.newText("신", 90, txtBox.y-100, "font/NanumSquareB.ttf", 22) 
    local line2 = display.newRoundedRect(npc.x, npc.y+11, 90, 3, 10)
	npc.alpha = 0
	line2.alpha = 0

local options = {
   text = "",
	y=player.y+200,
   width = txtBox.x,
   	x=txtBox.x/2+player.width/2+100,
   height = 300,
   fontSize = 19,
   align = "left",
   font= "font/NanumSquareB.ttf"
}
    local txt = display.newText(options)

    local tapButton = display.newImageRect("image/click.png", 160, 150) -- 다음 버
    tapButton.x, tapButton.y = 1225, txtBox.y+35
    tapButton.width, tapButton.height = 76.5, 51.5
    tapButton.alpha = 1

   	-- 대사 진행 정도
    local tNum = 0

    -- 대사 보이기
	local function showTxt()
		txt.alpha = 1
	end

	-- 대사 가리기
	local function hideTxt ()
		txt.alpha = 0
	end

	local function showPlayerName()
		player.alpha = 1
		line1.alpha = 0.6
		player_animation.alpha=1
	end

	local function hidePlayerName()
		player_animation.alpha=0
		player.alpha = 0
		line1.alpha = 0
	end

	local function showNpcName()
		npc.alpha = 1
		line2.alpha = 0.6
		npc_animation.alpha=1
	end

	local function hideNpcName()
		npc.alpha = 0
		line2.alpha = 0
		npc_animation.alpha=0
	end

	--
	-- 스토리가 끝난 후 게임 스타트 화면으로 이동하는 함수
	local function gotoStart(event)
sceneGroup:insert( bg )
sceneGroup:insert( bg1 )
sceneGroup:insert( pendant )
--npc 애니메이션 추가
sceneGroup:insert(npc_animation)
sceneGroup:insert(player_animation)
sceneGroup:insert(player_animation1)
sceneGroup:insert( txtBox)
sceneGroup:insert(line1)
sceneGroup:insert(player)
sceneGroup:insert(npc)
sceneGroup:insert(line2)
sceneGroup:insert(txt)
sceneGroup:insert(tapButton)
		composer.removeScene("script0")
		composer.setVariable("stageNum",stageNum)
		composer.gotoScene("stage",{effect="fade",time=2000})
	end
	-----
		if tNum == 0 then
		player_animation.alpha=1
		txt.text = "주인공 로르는 이 세상의 모든 색채를 어둠의 세력으로부터 지키는 색깔의 요정."

	end

    local function txtEvent()
    	--print("tNum is.."..tNum)
		if tNum == 1 then
			player_animation:play()
			txt.text = "빨간색, 파란색, 노란색, 검정색이 담긴 펜던트를 보호하는 임무를 맡고 있는 로르는, 이 펜던트를 자신의 목숨보다도 소중히 여기며 항상 제 품에 소중히 지니곤 했다. "
		elseif tNum == 2 then
			pendant.alpha=1
			pendant:setSequence("first")
			pendant:play()
			player_animation:play()
			txt.text = "어둠의 세력으로부터 몇 번이나 펜던트를 지켜낸 끝에,최근 몇 백 년 사이 어둠의 세력은 자취를 완전히 감추었으며 평화로운 나날이 지속되고 있다. "
		elseif tNum == 3 then
			pendant:pause()
			pendant:setFrame(5)
			
			playerBoring()
			txt.text = "더 이상 어둠의 세력이 출몰하지 않자 점점 안일해지고 나태해진 로르는, 펜던트를 지키는 일을 소홀히 하기 시작했다."
		elseif tNum == 4 then
			pendantFall()
			playerConfusing()
			txt.alpha=0
			txtBox.alpha=0
		elseif tNum == 5 then
		showPlayerName()
			txt.alpha=1
			txtBox.alpha=1
			txt.text = "(두 눈동자가 커지며) 안 돼!"
		elseif tNum == 6 then
			pendant.alpha=1
			pendant:pause()
			hidePlayerName()
			blue.alpha=1
			yellow.alpha=1
			red.alpha=1
			black.alpha=1

			transition.to( yellow, { time=1500, alpha=0, x=(display.contentWidth-50), y=(50)} )
			transition.to( red, { time=1500, alpha=0, x=(50), y=(display.contentHeight-50)} )
			transition.to( blue, { time=1500, alpha=0, x=(50), y=(50)} )
			transition.to( black, { time=1500, alpha=0, x=(display.contentWidth-50), y=(display.contentHeight-50)} )
			txt.y=txt.y-15
			txt.text = "급하게 손을 뻗어보지만 로르에겐 역부족이었다. 결국 쨍그랑거리는 소리와 함께 펜던트 안의 모든 색깔이 산산조각 나고, 노랑, 파랑, 빨강, 그리고 검정 빛이 펜던트에서 빠져나와 온 세상으로 날아간다."
		elseif tNum == 7 then
			showPlayerName()
			txt.text = "아아, 어쩌면 좋지? 잠깐 한눈 판 사이에 색깔들이 온 세상으로 퍼져나갔어…."
		elseif tNum == 8 then
		txt.y=txt.y+15
			pendant.alpha=0
			hidePlayerName()
			showNpcName()
			txt.text = "로르, 이게 어떻게 된 일이지?"
		elseif tNum == 9 then
			hideNpcName()
			showPlayerName()
			txt.text ="(고개를 푹 숙이곤 어쩔 줄 몰라 하는 목소리로) …죄송합니다. 정말 작은 실수였어요…"
		elseif tNum == 10 then
			hidePlayerName()
			showNpcName()
			txt.text = "색깔을 수호하는 것은 너의 임무. 너는 주어진 임무를 소홀히 했지."
		elseif tNum == 11 then
		bg.alpha=0
		bg1.alpha=1
			hideNpcName()
			showPlayerName()
			playerDespairingWithoutColor()
			txt.text = "(작은 손거울로 자신의 모습을 확인하곤 떨리는 목소리로 대화를 이어간다.) ……이, 이게 어떻게 된 일이죠? 저는 평생 이런 모습으로 살아야 하나요?"
		elseif tNum == 12 then
			hidePlayerName()
			showNpcName()
			txt.text = "(말없이 고개를 끄덕인다.)"
		elseif tNum == 13 then
			hideNpcName()
			showPlayerName()
			txt.text = "신이시여, 저에게 단 한 번만 기회를 더 주세요. 저, 반성하고 있어요. 목숨보다 소중히 여겨야 하는 펜던트를 제대로 보호하지 않은 것을…. 정말 무엇이든, 무엇이든 할 테니, 부디 처벌을 거둬주세요."
		elseif tNum==14 then
			hidePlayerName()
			showNpcName()
			txt.text = "나는 너를 더 이상 믿을 수 없구나."
		elseif tNum==15 then
			hidePlayerName()
			showNpcName()
			txt.text = "……허나, 네가 수 백 년 동안 펜던트를 열심히 보호한 것도 사실. 모든 만물은 실수를 거듭하기 마련이지. 정말 무엇이든 하겠느냐?"
		elseif tNum==16 then
			playerLast()
			hideNpcName()
			showPlayerName()
			txt.text = "(다급한 목소리로) 네! 무엇이든 하겠습니다!"
		elseif tNum==17 then
			hidePlayerName()
			showNpcName()
			txt.text = "그렇다면, 네게 딱 한 번 더 기회를 주지. 온 세상으로 퍼져 나간 색깔을 전부 찾아오도록 하여라. 단, 기간은 오늘 밤 자정까지. "
		elseif tNum==18 then
			hideNpcName()
			showPlayerName()
			playerConfusingWithoutColor()
			txt.text = "자, 자정까지요? 그건….."
		elseif tNum==19 then
			hidePlayerName()
			showNpcName()
			txt.text = "못하겠느냐?"
		elseif tNum==20 then
			hideNpcName()
			showPlayerName()
			playerLast()
			txt.text = "(눈물을 닦곤 고개를 가로저으며 애써 힘찬 목소리로 대답한다.) …아니에요, 지금 당장 떠나겠습니다!"
		else
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
