--! file: wool.lua
-- just some random functions for learning and stuff, 'wooly'

local wool = {}

function wool.createCounterTable()
    return {
        value = 1,
        increment = function(self)
                        self.value = self.value + 1
                    end
    }
end

function wool.sumTable()
    return {
        a = 1,
        b = 2,
        c = 3,
        sum = function(self)
            self.c = self.a + self.b + self.c
        end
    }
end

return wool