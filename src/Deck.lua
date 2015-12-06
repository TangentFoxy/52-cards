local class = require "lib.middleclass"
local insert = table.insert
local remove = table.remove
local random = math.random
local ceil = math.ceil
local lg = love.graphics

local Deck = class("Deck")

Deck.static.width = 64*2
Deck.static.height = 89*2

function Deck:initialize(cards)
    self.cards = cards or {}
    self.x = 0
    self.y = 0
    self.r = 0
    self.face = "down" --or "up"
end

function Deck:draw(face, x, y, r)
    if not face then face = self.face end
    if not x then x = self.x end
    if not y then y = self.y end
    if not r then r = self.r end

    lg.push()

    lg.translate(x, y)
    lg.rotate(r)
    lg.setColor(255, 255, 255, 255)

    for i=ceil(#self.cards / 3), 1, -1 do --every 3 cards is 1 pixel of thickness to the deck, rounded up
        lg.rectangle("line", i - Deck.static.width/2, i - Deck.static.height/2, Deck.static.width, Deck.static.height)
    end

    lg.pop()

    self.cards[#self.cards]:draw(face, x, y, r)
end

function Deck:moveTo(x, y, r)
    self.x = x or self.x
    self.y = y or self.y
    self.r = r or self.r
end

function Deck:flip()
    if self.face == "down" then
        self.face = "up"
    else
        self.face = "down"
    end
end

function Deck:shuffleCards()
    local new = {}

    while #self.cards > 0 do
        insert(new, remove(self.cards, random(1, #self.cards)))
    end

    self.cards = new
end

function Deck:shuffleIn(card) --TODO make capable of handling multiple cards
    --insert(self.cards, random(1, #self.cards)) --no, we shuffle everything!
    insert(self.cards, card)
    self:shuffleCards()
end
--TODO ? placeIn() to randomly place within without shuffling whole deck?

function Deck:drawCards(count)
    if count and (count > 1) then
        local new = {}

        while (count > 1) and (#self.cards > 1) do
            insert(new, remove(self.cards))
        end

        return Deck(new)
    else
        return remove(self.cards)
    end
end

--on top of deck
function Deck:placeCardsOn(cards)
    if type(cards) == "table" then
        for _, card in ipairs(cards) do
            insert(self.cards, card)
        end
    else
        insert(self.cards, cards)
    end
end

--on bottom of deck
function Deck:placeCardsUnder(cards)
    if type(cards) == "table" then
        for _, card in ipairs(cards) do
            insert(self.cards, card, 1)
        end
    else
        insert(self.cards, cards, 1)
    end
end

function Deck:getCards()
    return self.cards
end

return Deck
