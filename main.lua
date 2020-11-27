--! file: main.lua
Object = require "libraries.classic"
Input = require "libraries.input"
--Timer = require "libraries.hump.timer"
Timer = require "libraries.enhanced_timer.EnhancedTimer"
M = require "libraries.yonaba.moses"
local quick = require "libraries.quick"
local wool = require "modules.wool"
local object_files = {}
local current_room

function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

function love.load()
    input = Input()
    timer = Timer()
    quick.recursiveEnumerate('objects', object_files)
    quick.requireFiles(object_files)

    current_room = nil
end

function love.update(dt)

end

function love.draw()

end