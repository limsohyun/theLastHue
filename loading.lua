-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
   local sceneGroup = self.view

local bg = display.newImageRect("image/roading.png",display.contentWidth,display.contentHeight)
bg.x,bg.y=display.contentWidth/2,display.contentHeight/2

  local function downEvent(event)
    composer.setVariable("stageNum",0)
    composer.gotoScene("script"..0,{effect="fade",time=2000})
  end
  bg:addEventListener("tap",downEvent)
  
local startText = display.newText("STORY START", 160, 25, "Arial", 25)
startText.x , startText.y=display.contentWidth/2+10,display.contentHeight-display.contentHeight/3

function flashing_text(textToFlash)
    local r = math.random(0,100)
    local g = math.random(0,100)
    local b = math.random(0, 100)

    if(textToFlash.alpha < 1) then
        textToFlash:setFillColor(r/100,g/100,b/100)
        transition.to( textToFlash, {time=490, alpha=1})
    else 
        transition.to( textToFlash, {time=490, alpha=0.1})
    end
end
txt_flash = timer.performWithDelay(550, function() flashing_text(startText) end, 0)


sceneGroup:insert( bg )
sceneGroup:insert( startText )

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