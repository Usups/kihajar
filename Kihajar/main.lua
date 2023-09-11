_G.lg = love.graphics
_G.lm = love.mouse
local UrutoraReq = require("urutora.init")
local Urutora = UrutoraReq:new()
require 'urutora.fonts'

function love.mousepressed(x, y, button) Urutora:pressed(x, y, button) end
function love.mousemoved(x, y, dx, dy) Urutora:moved(x, y, dx, dy) end
function love.mousereleased(x, y, button) Urutora:released(x, y, button) end
function love.textinput(text) Urutora:textinput(text) end
function love.keypressed(k, scancode, isrepeat) Urutora:keypressed(k, scancode, isrepeat) if k == 'escape' then love.event.quit() end end
function love.wheelmoved(x, y) Urutora:wheelmoved(x, y) end


local bgColor = { 1, 1, 1 }
local function initCanvasStuff()
    w, h = love.graphics.getDimensions()
    canvas = lg.newCanvas(w, h)
    canvas:setFilter('nearest', 'nearest')
    canvasX, canvasY = 0, 0
    sx = lg.getWidth() / canvas:getWidth()
    sy = lg.getHeight() / canvas:getHeight()
end
  
  local function doResizeStuff(w, h)
    sx = math.floor(w / canvas:getWidth())
    sx = sx < 1 and 1 or sx
    sy = sx
  
    if (canvas:getHeight() * sy) > h then
      sy = math.floor(h / canvas:getHeight())
      sy = sy < 1 and 1 or sy
      sx = sy
    end
  
    canvasX = w / 2 - (canvas:getWidth() / 2) * sx
    canvasY = h / 2 - (canvas:getHeight() / 2) * sy
  
    Urutora.setDimensions(canvasX, canvasY, sx, sy)
end
local function Init()
    initCanvasStuff()
    Urutora.setDefaultFont(proggyTiny)
    doResizeStuff(love.graphics.getDimensions())
    SavedData = require("data")
end

local function MainPanelInit()
    local Panel = Urutora.panel({
        rows = 9, cols = 5,
        w = w, h = h,
        scrollSpeed = 1/18,
        verticalScale = 2,})
        :addAt(1, 1, Urutora.label({text = 'Label:' }))
        :addAt(1, 1, Urutora.toggle()
        :action(function (evt)
          evt.target.parent.debug = evt.value
        end))
        :addAt(5,3, Urutora.button({text = "test"}):action(function (evt)
            Urutora:remove(evt.target.parent)
        end))
    return Panel
end

function love.update(dt)
    Urutora:update(dt)
end
function love.draw()
    Urutora:draw()
end

function love.load()
    Init()
    local Panel = MainPanelInit()
    Urutora:add(Panel)
end