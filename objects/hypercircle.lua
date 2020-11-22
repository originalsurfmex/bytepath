--! file: hypercircle.lua

--local HyperCircle = Circle:extend()
HyperCircle = Circle:extend()
local distance
local widthy

function HyperCircle:new(x, y, radius, outer_radius_distance, line_width)
    HyperCircle.super.new(self, x, y)
    self.radius = radius
    self.outer_radius = self.radius + outer_radius_distance
    self.line_width = line_width
    distance = self.outer_radius
    widthy = self.line_width
end

function HyperCircle:update(dt)
    self.outer_radius = love.math.random(self.radius, distance + 200)
    self.line_width = love.math.random(1, widthy)
end

function HyperCircle:draw()
    love.graphics.setLineWidth(self.line_width)
    love.graphics.circle('line', self.x, self.y, self.outer_radius)
end

--return HyperCircle