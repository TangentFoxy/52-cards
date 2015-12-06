local class = require "lib.middleclass"
local lg = love.graphics
local cornerOffset = 5

local Card = class("Card")

Card.static.width = 64*2
Card.static.height = 89*2

function Card:initialize(suit, rank)
    self.suit = suit or "!"
    self.rank = rank or "#"
    self.x = 0
    self.y = 0
    self.r = 0
    self.face = "down" --or "up"
end

function Card:draw(face, x, y, r)
    if not face then face = self.face end
    if not x then x = self.x end
    if not y then y = self.y end
    if not r then r = self.r end

    lg.push()

    lg.translate(x, y)
    lg.rotate(r)
    lg.setColor(0, 0, 0, 255)
    lg.rectangle("fill", -Card.static.width/2, -Card.static.height/2, Card.static.width, Card.static.height)
    lg.setColor(255, 255, 255, 255)
    lg.rectangle("line", -Card.static.width/2, -Card.static.height/2, Card.static.width, Card.static.height)

    if face == "up" then
        if self.rank == "Joker" then
            lg.print("Joker", cornerOffset - Card.static.width/2, cornerOffset - Card.static.height/2)
            -- I wanted this to be a symbol for a suit, but the Joker doesn't have one!
            lg.print("#")
        else
            lg.print(self.rank .. " of " .. self.suit, cornerOffset - Card.static.width/2, cornerOffset - Card.static.height/2)
            if self.suit == "Clubs" then
                lg.print("♣")
            elseif self.suit == "Diamonds" then
                lg.print("♦")
            elseif self.suit == "Hearts" then
                lg.print("♥")
            elseif self.suit == "Spades" then
                lg.print("♠")
            else
                lg.print("!")
            end
        end
    end

    lg.pop()
end

function Card:moveTo(x, y, r)
    self.x = x or self.x
    self.y = y or self.y
    self.r = r or self.r
end

function Card:getPosition()
    return self.x, self.y, self.r
end

function Card:flip()
    if self.face == "down" then
        self.face = "up"
    else
        self.face = "down"
    end
end

return Card
