--! file: main.lua

Object = require "libraries.classic"
--Test = require 'objects.test'
--Circle = require 'objects.circle'
--HyperCircle = require 'objects.hypercircle'

local image
local object_files
local c1
local hc1
local counter_table
local sumtest, sumtest2

local function createCounterTable()
    return {
        value = 1,
        increment = function(self)
                        self.value = self.value + 1
                    end
    }
end

local function sumTable()
    return {
        a = 1,
        b = 2,
        c = 3,
        sum = function(self)
            self.c = self.a + self.b + self.c
        end
    }
end

--LOL duh, lua has no split (what the heck)
function string:split( inSplitPattern )
    local outResults = {}
    local theStart = 1
    local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
    while theSplitStart do
        table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
        theStart = theSplitEnd + 1
        theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
    end
    table.insert( outResults, string.sub( self, theStart ) )
    return outResults
end

function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end

function recursiveEnumerate(folder, file_list)
    local filesTable = love.filesystem.getDirectoryItems(folder)
    for i,v in ipairs(filesTable) do
        local file = folder .. '/' .. v
        if love.filesystem.getInfo(file, 'file') then
            table.insert(file_list, file)
        elseif love.filesystem.getInfo(file, 'directory') then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
  for _,filepath in ipairs(files) do
    local filepath = filepath:sub(1, -5)
    local parts = filepath:split("/")
    --somehow this gets the capitalization right, but how? idunno yet
    local class = parts[#parts]
    _G[class] = require(filepath)
  end
end

function love.load()
   recursiveEnumerate('objects', object_files)
   requireFiles(object_files)

   image = love.graphics.newImage('image.png')
   c1 = Circle(400, 300, 50)
   hc1 = HyperCircle(400, 300, 50, 50, 50)
   counter_table = createCounterTable()
   sumtest = sumTable()
   sumtest:sum()
end

function love.update(dt)
    c1:update(dt)
    hc1:update(dt)
    counter_table:increment()
end

function love.draw()
    for i,v in ipairs(object_files) do
        love.graphics.print(object_files[i], 20, 20 + (i * 10))
    end
    -- love.graphics.print(counter_table.value, 20, 20)
    --love.graphics.print(sumtest.c, 40, 40)
    love.graphics.draw(image, love.math.random(0,800), love.math.random(0, 600))
    c1:draw()
    hc1:draw()
end