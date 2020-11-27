--! file: convenient.lua
-- stuff i'm cobbling together for convenience

local quick = {}

function quick.split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function quick.recursiveEnumerate(folder, file_list)
    local filesTable = love.filesystem.getDirectoryItems(folder)
    for i,v in ipairs(filesTable) do
        local file = folder .. '/' .. v
        if love.filesystem.getInfo(file, 'file') then
            table.insert(file_list, file)
        elseif love.filesystem.getInfo(file, 'directory') then
            quick.recursiveEnumerate(file, file_list)
        end
    end
end

function quick.requireFiles(files)
  for _,filepath in ipairs(files) do
    local filepath = filepath:sub(1, -5)
    --local parts = mysplit(filepath, "/")
    local parts = quick.split(filepath, "/")
    local class = parts[#parts]
    _G[class] = require(filepath)
  end
end

return quick