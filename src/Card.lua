local set = setmetatable
local lg = love.graphics

local Card = {}

function Card.initialize(suit, rank)
    local self = {}

    self.suit = suit or "!"
    self.rank = rank or "#"
    self.x = 0
    self.y = 0
    self.r = 0
    self.face = "down" --or "up"

    set(self, {__index = Card})
    return self
end

function Card:draw(face, x, y, r)
    if not face then face = self.face end
    if not x then x = self.x end
    if not y then y = self.y end
    if not r then r = self.r end

    lg.translate(x, y)
    lg.rotate(r)
    lg.translate(x, y)
    --TODO if Joker, no suit!
    lg.print(self.rank .. " of " .. self.suit)
end

function Card:moveTo(x, y, r)
    self.x = x or self.x
    self.y = y or self.y
    self.r = r or self.r
end

function Card:flip()
    if self.face == "down" then
        self.face = "up"
    else
        self.face = "down"
    end
end

set(Card, {__call = Card.initialize})
return Card
