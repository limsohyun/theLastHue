-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
physics.start(true)
physics.setGravity( 0, 6)
--physics.setDrawMode( "hybrid" )
--1) 게임에 사용될 랜덤함수 미리 초기화
math.randomseed(os.time())
--2) widget 라이브러리 추가(아래서 사용할 것임)
local widget=require("widget")
--3) 점수 변수 선언
local bg
local piece={}
local count=0
local num=1
local save={}
local location=display.contentWidth/2
local pieceNum=0
local player
function scene:create( event )
   local sceneGroup = self.view

bg = display.newImageRect("image3/evening_before.png",display.contentWidth,display.contentHeight)
bg.x,bg.y=display.contentWidth/2,display.contentHeight/2


local shape = { -70,-30,-70,-100,70,-30,70,-100 }
 player=display.newImageRect("image3/player.png",150,200)
player.x,player.y=location,display.contentHeight-150

physics.addBody( player, "static",{shape=shape })


local function onKeyEvent( event )

    if(event.keyName=="right") then
		if(player.x<1152) then
		player.x=player.x+256/2
		end
    else
		if(player.x>128) then
		player.x=player.x-256/2
		end
	end
    return false
end
 
-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

	local function createPieces(event)
		local pieces = {'image/blue.png', 'image/yellow.png', 'image/red.png','image/black.png'}
		local n=math.random(1,4)
		
		if n==1 then
		piece[count]= display.newImage(pieces[n])
		piece[count].name="blue"
		elseif n==2 then
		piece[count] = display.newImage(pieces[n])
		piece[count].name="yellow"
		elseif n==3 then
		piece[count] = display.newImage(pieces[n])
		piece[count].name="red"
		else 
		piece[count] = display.newImage(pieces[n])
		piece[count].name="black"
		end


		piece[count].width = 200
		piece[count].height = 200
		piece[count].x = math.random(50, 1200)
		piece[count].y = 0


		physics.addBody(piece[count], {friction=0,radius=25})
		count=count+1
	end
local d = timer.performWithDelay(700, createPieces, -1)


	-- Create bombs
	local function createBomb(event)
		local bomb = display.newImage("image/grass.png")
		bomb.width = 100
		bomb.height = 100
		bomb.x = math.random(50, 1200)
		bomb.y = 0
		bomb.name = "bomb"

		physics.addBody(bomb, {friction=1})
	end

	local dropBombs = timer.performWithDelay(math.random(2500,3000), createBomb, -1)

-- 종료 조건 함수
	local function gotoResult(sCount)
	Runtime:removeEventListener( "key", onKeyEvent )
	player:removeSelf()
	player=nil
	--physics.stop()
		sceneGroup:insert(bg)
		--sceneGroup:insert(player)
		for i=1,num-1,1 do
		sceneGroup:insert(save[i])
		end

		timer.pause(d)
		timer.pause(dropBombs)

    	composer.setVariable("pieceNum", pieceNum)
		composer.removeScene("game3")
    	composer.gotoScene("game3_result")
    end

local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then

		if (event.other.name=="bomb") then
			pieceNum=0
			gotoResult()
		else
			if(event.other.name=="red") then
			pieceNum=pieceNum+1
			end

		save[num]=display.newImage("image/"..event.other.name..".png")
		save[num].y=100
		save[num].x=50*(num+1)
		save[num].width=150
		save[num].height=150
		num=num+1

		event.other:removeSelf()
		event.other=nil
		end

		if(num>10) then
		gotoResult()
		else

		end
    elseif ( event.phase == "ended" ) then
    end
end 
	player.collision = onLocalCollision
    player:addEventListener( "collision" )

--main finish
end

		



function scene:show( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if phase == "will" then
   elseif phase == "did" then
      -- e.g. start timers, begin animation, play audio, etc.
   end   
end

function scene:hide( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if event.phase == "will" then
      -- e.g. stop timers, stop animation, unload sounds, etc.)
   elseif phase == "did" then
   end
end

function scene:destroy( event )
   local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene