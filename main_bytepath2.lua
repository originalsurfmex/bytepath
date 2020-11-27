--! file: main.lua
Object = require "libraries.classic"
Input = require "libraries.input"
--Timer = require "libraries.hump.timer"
Timer = require "libraries.enhanced_timer.EnhancedTimer"
M = require "libraries.yonaba.moses"

local quick = require "libraries.quick"
local wool = require "modules.wool"

local image, input, timer, timer2
local object_files = {}
local c1, hc1, c2, rect_1, rect_2, a_t, atween, ago
local hbar_1, hbar_2, hit_1, hit_2, heal_1, heal_2
local circly
local counter_table, sumtest, sumtest2
--local a, b, c, d
a, b, c, d = 0


function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

function love.load()
    input = Input()
    timer = Timer()
    timer2 = Timer()
    quick.recursiveEnumerate('objects', object_files)
    quick.requireFiles(object_files)

    input:bind('1', 'test')
    input:bind('mouse1', 'test')
    input:bind('k', 'hits')
    input:bind('h', 'heals')

    --timer:every(1, function() print(love.math.random()) end, 5)

    for i=1,10 do
        timer:after(0.5 * i, function() print(love.math.random()) end)
    end

    image = love.graphics.newImage('image.png')
    c1 = Circle(400, 300, 50)
    circly = {x = 400, y = 300, rad = 10}
    local grow,shrink
    grow = function() timer:tween(3, circly, {rad = 200}, 'in-out-cubic', shrink) end
    shrink = function() timer:tween(3, circly, {rad = 10}, 'in-out-cubic', grow) end
    grow()

    hc1 = HyperCircle(400, 300, 50, 50, 50)
    counter_table = wool.createCounterTable()
    sumtest = wool.sumTable()
    sumtest:sum()

    rect_1 = {x = 400, y = 300, w = 50, h = 200}
    rect_2 = {x = 400, y = 300, w = 200, h = 50}
    local cross1, cross2, cross1rev, cross2rev
    cross1 = function() timer:tween(1, rect_1, {w=0}, 'in-out-cubic') end
    cross2 = function() timer:tween(1, rect_2, {h=0}, 'in-out-cubic') end
    cross1rev = function() timer:tween(2, rect_1, {w=50}, 'in-out-cubic') end
    cross2rev = function() timer:tween(2, rect_2, {h=50}, 'in-out-cubic') end

    hbar_1 = {x = 20, y = 530, w = 300, h = 50}
    hbar_2 = {x = 20, y = 530, w = 300, h = 50}
    hit_1 = function() timer:tween(4, hbar_1, {w = hbar_1.w * 0.65}, 'bounce') end
    hit_2 = function() timer:tween(1, hbar_2, {w = hbar_2.w * 0.65}, 'sine') end
    heal_1 = function() timer:tween(2, hbar_1, {w = 300}, 'sine') end
    heal_2 = function() timer:tween(1, hbar_2, {w = 300}, 'in-out-cubic') end

    timer:after(2, function(r)
        cross1()
        timer:after(1, function()
            cross2()
            timer:after(2, function()
                cross1rev()
                cross2rev()
                timer:after(4, r)
            end)
        end)
    end)

    a_t = 10
    atween = {avalue = 10}
    ago = function()timer:tween(1, atween, {avalue = 20}, 'sine') print(atween.avalue) end
    ago()

    a = {1, 2, '3', 4, '5', 6, 7, true, 9, 10, 11, a = 1, b = 2, c = 3, {1, 2, 3}}
    b = {1, 1, 3, 4, 5, 6, 7, false}
    c = {'1', '2', '3', 4, 5, 6}
    d = {1, 4, 3, 4, 5, 6}
end

function love.update(dt)
    c1:update(dt)
    hc1:update(dt)
    timer:update(dt)
    counter_table:increment()

    if input:pressed('test') then print('pressed') end
    if input:released('test') then print('released') end
    if input:down('test', 0.5) then print('down') end
    if hbar_2.w > 50 then
        if input:pressed('hits') then hit_1() hit_2() end
    end
    if input:pressed('heals') then heal_1() heal_2() end

    if hbar_1.w < 10 then hbar_1.w=10 hbar_2.w=10 heal_1() heal_2() end
    if hbar_1.w > 300 then hbar_1.w=300 hbar_2.w=300 end
    if hbar_2.w < 10 then hbar_1.w=10 hbar_2.w=10 heal_1() heal_2() end
    if hbar_2.w > 300 then hbar_1.w=300 hbar_2.w=300 end
    a_t = atween.avalue

end

function love.draw()
    if a_t < 20 then print(a_t) end

    love.graphics.setColor(1,1,1)
    for i,v in ipairs(object_files) do
        love.graphics.print(object_files[i], 20, 20 + (i * 10))
    end
    for i=1,50 do love.graphics.print(love.math.random(), 20, 60 + (i*10)) end

    love.graphics.draw(image, love.math.random(0,800), love.math.random(0, 600))
    c1:draw()
    hc1:draw()


    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill', hbar_1.x, hbar_1.y, hbar_1.w, hbar_1.h)
    love.graphics.rectangle('fill', rect_1.x - rect_1.w/2, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
    love.graphics.rectangle('fill', rect_2.x - rect_2.w/2, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)
    love.graphics.setLineWidth(1)
    love.graphics.circle('line', circly.x, circly.y, circly.rad)

    love.graphics.setColor(1,0,1)
    love.graphics.rectangle('fill', hbar_2.x, hbar_2.y, hbar_2.w, hbar_2.h)

end