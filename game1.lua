-----------------------------------------------------------------------------------------
--
-- view.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local bg = display.newImageRect( "image1/before.png", display.contentWidth, display.contentHeight)
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local main = display.newRect( display.contentWidth/2 + 50, display.contentHeight/ 2, display.contentWidth- 240, display.contentHeight - 130 )
	main:setFillColor( 1 )
	main.alpha = 0.7
	main.y = display.contentCenterY

	local score = display.newRect( display.contentWidth/2 - 550, display.contentHeight/2 - 250, 120, 125 )
	score:setFillColor( 1 )
	score.alpha = 0.8

	local scoreCount = 0

	local scoreText = display.newText( scoreCount, score.x, score.y, "font/NanumSquareR.ttf", 50 )
	scoreText:setFillColor( 0.3, 0.3, 0.8 )
	scoreText.size = 60

	local num1 = main.x - 375
	local num2 = main.y - 190

	local text = {}
	local one = 0
	local two = 0
	local three = 0
	local four = 0
	local five = 0 
	local six = 0

	local card = {}
	local count = 0
	local showText = {}
	
	local fir, sec
	--실제 reset 해주는 함수
	local function reset2( ... )
		for i = 1, 12, 1 do
			if i == fir or i == sec then
				showText[i].alpha = 0
			end
		end
	end

	--reset2 함수 보조
	local function reset(number1, number2)
		timer.performWithDelay(1000, reset2, 1)
		fir = number1
		sec = number2
	end
	
	--game에 대한 전반적인 내용 다 포함.
	local function setGame()
		--카드 생성
	local function reNumber(i)
		-- body
		text[i] = math.random(6)
		if text[i] == 1 then
			if one >= 2 then
				print("re1 됌")
				reNumber(i)
			else
				one = one + 1
			end
		elseif text[i] == 2 then
			if two >= 2 then
				print("re2 됌")
				reNumber(i)
			else
				two = two + 1
			end
		elseif text[i] == 3 then
			if three >= 2 then
				print("re3 됌")
				reNumber(i)
			else
				three = three + 1
			end
		elseif text[i] == 4 then
			if four >= 2 then
				print("re4 됌")
				reNumber(i)
			else
				four = four + 1
			end
		elseif text[i] == 5 then
			if five >= 2 then
				print("re5 됌")
				reNumber(i)
			else
				five = five + 1
			end
		elseif text[i] == 6 then
			if six >= 2 then
				print("re6 됌")
				reNumber(i)
			else
				six = six + 1
			end
		end
	end

	for i = 1, 12, 1 do
		text[i] = math.random(6)
		print(i.."번째 실행됌")
		if text[i] == 1 then
			if one >= 2 then
				print("re1 됌")
				reNumber(i)
			else
				one = one + 1
			end
		elseif text[i] == 2 then
			if two >= 2 then
				print("re2 됌")
				reNumber(i)
			else
				two = two + 1
			end
		elseif text[i] == 3 then
			if three >= 2 then
				print("re3 됌")
				reNumber(i)
			else
				three = three + 1
			end
		elseif text[i] == 4 then
			if four >= 2 then
				print("re4 됌")
				reNumber(i)
			else
				four = four + 1
			end
		elseif text[i] == 5 then
			if five >= 2 then
				print("re5 됌")
				reNumber(i)
			else
				five = five + 1
			end
		elseif text[i] == 6 then
			if six >= 2 then
				print("re6 됌")
				reNumber(i)
			else
				six = six + 1
			end
		end
		print(one.."-one"..two.."-two"..three.."-three"..four.."-four"..five.."-five"..six.."-six")
	end

		for i = 1, 12, 1 do
		card[i] = display.newRect( num1, num2, 230, 170 )
		card[i]:setFillColor( math.random())
	
		showText[i] = display.newText(text[i], num1, num2, "font/NanumSquareB.ttf", 50)
		showText[i]:setFillColor( 0.4, 0.5, 0.9 )
		showText[i].alpha = 0
		showText[i].size = 75
		print("alpha = 0임")
		num1 = num1 + 250
	
		if i % 4 == 0 then
			 num2 = num2 + 190
			 num1 = main.x - 375
		end
		end

		for i = 1, 12, 1 do
			print(i..":"..text[i])
		end
	--print("1:"..text.." 2:"..two.." 3:"..three.." 4:"..four.." 5:"..five.." 6:"..six)

	local minus = 0

	--result.lua로 전환하는 함수.
	local function gotoResult()
	      composer.setVariable("score", scoreCount)
	      composer.setVariable("min", minus)
	      composer.removeScene("game1")
	      composer.gotoScene("game1_result")
	
	      sceneGroup:insert(bg)
		  sceneGroup:insert(main)
	      sceneGroup:insert(score)
		  sceneGroup:insert(scoreText)
		  for i = 1, #showText, 1 do
	     		sceneGroup:insert(showText[i])
	  	  end
	 	  for i = 1, #card, 1 do
		 	 sceneGroup:insert(card[i])
		  end
	end

	local number1, number2, n, last

	--마지막 카드가 안보이는 문제가 생기지 않게 하는 함수. // 아직 해결 안됨.
	local function lastCard()
		for i = 1, 12, 1 do
			if i == last then
				print("마지막 카드")
				showText[i].alpha = 1
				showText[i].size = 80
			end
		end
			gotoResult()
	end

	local function last(num)
		timer.performWithDelay(300, lastCard, 1)
		last = num
		print("last()함수까지 실행됨")		
	end
	--두 개의 카드 같은지 비교
	local function twoCard(n1, n2)
		-- body
		if showText[n1].text == showText[n2].text then
			scoreCount = scoreCount + 1
			scoreText.text = scoreCount
			print(scoreCount .."count + 됌")
			print(minus.."minus의 수")
			if scoreCount + minus == 5 then
				last(n2)
			end
		else
			minus = minus + 1
			print( minus.."마이너스")
			if scoreCount + minus == 5 then
				last(n2)
			end
			reset(n1, n2)
		end
		if scoreCount + minus ~= 5 then
			count = 0
		end
	end

	--첫번째 카드와 두번째 카드임을 판별하고 클릭된 카드 인덱스 저장.
	local function setNum(num, c)-- body
		if c == 1 then
			number1 = num
			print(number1.."number1")
			print(showText[number1].text.."number1 숫자")
		elseif c >= 2 then
			print(c .." - 카운트" )
			number2 = num
			print(number2.."number2")
			print(showText[number2].text.."number2는 몇일까")
			twoCard(number1, number2)
		end
	end

	--카드 번호 생성
	local function card1()
		showText[1].alpha = 1
		print("11")
		count = count + 1
		n = 1 
		setNum(n, count)
	end

	local function card2()
		showText[2].alpha = 1
		print("22")
		count = count + 1
		n = 2
		setNum(n, count)
	end

	local function card3()
		showText[3].alpha = 1
		count = count + 1
		n = 3
		setNum(n, count)
	end

	local function card4()
		showText[4].alpha = 1
		count = count + 1
		n = 4
		setNum(n, count)
	end

	local function card5()
		showText[5].alpha = 1
		count = count + 1
		n = 5
		setNum(n, count)
	end

	local function card6()
		showText[6].alpha = 1
		count = count + 1
		n = 6
		setNum(n, count)
	end

	local function card7()
		showText[7].alpha = 1
		count = count + 1
		n = 7
		setNum(n, count)
	end

	local function card8()
		showText[8].alpha = 1
		count = count + 1
		n = 8
		setNum(n, count)
	end

	local function card9()
		showText[9].alpha = 1
		count = count + 1
		n = 9
		setNum(n, count)
	end

	local function card10()
		showText[10].alpha = 1
		count = count + 1
		n = 10
		setNum(n, count)
	end

	local function card11()
		showText[11].alpha = 1
		count = count + 1
		n = 11
		setNum(n, count)
	end

	local function card12()
		showText[12].alpha = 1
		count = count + 1
		n = 12
		setNum(n, count)
	end

	for i = 1, 12, 1 do
		if i == 1 then
			card[1]:addEventListener( "tap", card1 )
			print("1")
		elseif i == 2 then
			card[2]:addEventListener( "tap", card2 )
			print("2")
		elseif i == 3 then
			card[3]:addEventListener( "tap", card3 )
		elseif i == 4 then
			card[4]:addEventListener( "tap", card4 )
		elseif i == 5 then
			card[5]:addEventListener( "tap", card5 )
		elseif i == 6 then
			card[6]:addEventListener( "tap", card6 )
		elseif i == 7 then
			card[7]:addEventListener( "tap", card7 )
		elseif i == 8 then
			card[8]:addEventListener( "tap", card8 )
		elseif i == 9 then
			card[9]:addEventListener( "tap", card9 )
		elseif i == 10 then
			card[10]:addEventListener( "tap", card10 )
		elseif i == 11 then
			card[11]:addEventListener( "tap", card11 )
		elseif i == 12 then
			card[12]:addEventListener( "tap", card12 )
		end
	end
	end

	local guide = display.newRect( display.contentWidth/2 + 75, display.contentHeight/ 2, display.contentWidth - 350, display.contentHeight - 200 )
	guide:setFillColor( 0.9, 0.7, 0.7 )
	guide.alpha = 0.5
	guide.y = display.contentCenterY
	local guideBox = display.newRect( display.contentWidth/2 + 75, display.contentHeight/ 2, display.contentWidth - 400, display.contentHeight - 250 )
	guideBox:setFillColor( 0.5 )
	guideBox.alpha = 0.7
	guideBox.y = display.contentCenterY

	local guideText = display.newText(" ", display.contentWidth/2 + 70, display.contentHeight/ 2 - 70, "font/NanumSquareB.ttf", 25)
	guideText:setFillColor(0)
	guideText.text = "                                       <게임 주의사항>\n\n\n카드 두장을 선택해 같은 숫자가 쓰인 카드를 찾는 게임입니다. \n같은 카드를 찾으면 점수가 1점 올라가고 다섯번의 기회 중 \n3점 이상을 획득하면 성공입니다. \n\n3점 이상 획득 실패시 재도전 할 수 있습니다. \n\n*게임을 시작하시려면 다음 버튼을 눌러주세요. \n"
	

	local button = display.newImage( "image1/button.png", display.contentWidth/2 + 75, display.contentHeight/ 2 + 130)

	local function buttonClick()
		guide.alpha = 0
		guideBox.alpha = 0
		guideText.alpha = 0
		button.alpha = 0
		setGame()
	end

	button:addEventListener( "tap", buttonClick )

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
		composer.removeScene("view")
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