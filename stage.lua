local composer = require( "composer" )
local scene = composer.newScene()
local stageNum=composer.getVariable("stageNum")
function scene:create( event )
	local sceneGroup = self.view
	local stageUI={}

print("stage"..stageNum)
	local bg = display.newImage( "image/bg"..stageNum..".png", display.contentWidth, display.contentHeight)
    bg.x = display.contentWidth/2
    bg.y = display.contentHeight/2

    
    --주인공 걷는 애니메이션
local sheetOptions =
{
    width = 200,
    height = 250,
    numFrames = 3,
}

local sequences_player = {
    -- consecutive frames sequence
    {
        name = "normalRunR",
        start = 1,
        count = 3,
        time = 600,
        loopCount = 0,
        loopDirection = "forward"
    }
}


location = 500

local sheet_player = graphics.newImageSheet( "image/player.png", sheetOptions )
local player = display.newSprite( sheet_player, sequences_player)
player.xScale,player.yScale=0.5,0.5
player:play()


     stageUI[1] = display.newImage( "image/stage1.png", display.contentWidth/4, display.contentHeight/4)
     stageUI[2] = display.newImage( "image/stage2.png", display.contentWidth/4, display.contentHeight/4)
     stageUI[3] = display.newImage( "image/stage3.png", display.contentWidth/4, display.contentHeight/4)
     stageUI[4] = display.newImage( "image/stage4.png", display.contentWidth/4, display.contentHeight/4)

     --스테이지 위치 조정
    for i=1 , 4 , 1 do
    	stageUI[i].x=220*i+100
    	stageUI[i].y=display.contentHeight-100*i
    end
    stageUI[4].y=display.contentHeight-200
    	
    --스테이지 효과
    for i=1,4,1 do
    	if stageNum==i then
    	stageUI[i].xSacle,stageUI[i].ySacle=1,1
    	else
    	stageUI[i].xScale,stageUI[i].yScale=0.5,0.5
    	stageUI[i].alpha=0.5
    end
        	    transition.from(stageUI[i],{
    		time = 1000+i*200,
    		yScale =0.1,
    		xScale =0.1,
    		transition = easing.linear
    	});
    end

    --스테이지 클릭시 다음 화면 넘어가는 함수
    local function moveStage(event)
		composer.removeScene("stage")
    	local pageName="script"..stageNum
    	composer.setVariable("stageNum",stageNum)
		
     	composer.gotoScene(pageName,{effect="fade",time=2000})
    end
    stageUI[stageNum]:addEventListener("tap",moveStage)

    --transition.fadeIn( stageUI[stageNum],{ time=3000 })

    --오른쪽 위 펜던트 진행 상황
    local pendant
    local function progressStage()
	    player.x=stageUI[stageNum].x
    	player.y=stageUI[stageNum].y

		pendant=display.newImage( "image/pendant"..(stageNum-1)..".png", display.contentWidth-100, 100)

		if stageNum==2 then
		    player.y=player.y-10
    	elseif stageNum==3 then
			player.y=player.y-5
		elseif stageNum==4 then
			player.y=player.y-10
		else
		end
		pendant.xScale,pendant.yScale=0.3,0.3
    end
progressStage()

sceneGroup:insert( bg )
for i=1 ,4, 1 do
	sceneGroup:insert( stageUI[i] )
end

sceneGroup:insert( player)
sceneGroup:insert( pendant)
composer.removeScene( "stage" )
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
