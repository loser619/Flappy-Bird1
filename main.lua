push=require 'push'
Class=require'class'
require 'bird'
require 'pipes'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountDownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'


WINDOWS_WIDTH=1280
WINDOWS_HEIGHT=720

VIRTUAL_WIDTH=512
VIRTUAL_HEIGHT=288

local lastY= -PIPE_HEIGHT +math.random(80) +20
local background=love.graphics.newImage('background.png')
local ground=love.graphics.newImage('ground.png')
local backgroundScroll=0
local groundScroll=0

local BACK_GROUND_SPEED=30
local GROUND_SPEED=60
local LOOPING_POINT=413
local bird=Bird()
local pipePairs={}
local spawnTimer=0
local scrolling =true
function love.load()

  love.graphics.setDefaultFilter('nearest','nearest')

  push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOWS_WIDTH,WINDOWS_HEIGHT,{
         vsync=true,
         fullscreen=false,
         resizable=true
    })

    gStateMachine =StateMachine{
      ['title']=function() return TitleScreenState() end,
      ['play']=function() return PlayState() end,
      ['score']=function() return ScoreState() end,
      ['countdown']=function() return CountDownState() end
    }
    gStateMachine:change('title')
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    love.keyboard.keysPressed={}

  end

  function love.update(dt)


      backgroundScroll=(backgroundScroll + BACK_GROUND_SPEED *dt) %LOOPING_POINT
      groundScroll=(groundScroll + GROUND_SPEED *dt) % VIRTUAL_WIDTH

      gStateMachine:update(dt)


        -- body...
      


      love.keyboard.keysPressed={}
  end





  function love.resize(w, h)
    push:resize()
  end

  function love.keypressed(key)
    love.keyboard.keysPressed[key]=true
    if key=='escape' then
      love.event.quit()
    end

  end

  function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
      return true
    else
      return false
    end
  end

  function love.draw()
    push:start()
    love.graphics.draw(background,-backgroundScroll,0)
    gStateMachine:render()
    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)

    push:finish()
  end
