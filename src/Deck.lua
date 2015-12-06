local set = setmetatable
local insert = table.insert
local remove = table.remove
local random = math.random
local floor = math.floor
local lg = love.graphics

local Deck = {}

local inspect = require "lib.inspect" --NOTE DEBUG

function Deck.initialize(cards)
    local self = {}

    print(inspect(cards)) --NOTE DEBUG
    self.cards = cards or {}
    self.x = 0
    self.y = 0
    self.r = 0
    self.face = "down" --or "up"

    set(self, {__index = Deck})
    return self
end

function Deck:draw()
    local thickness = floor(#self.cards / 3)
    print(inspect(self.cards)) --NOTE DEBUG
    self.cards[#self.cards]:draw(self.face, self.x, self.y, self.r)

    --TODO draw the extra lines
end

function Deck:moveTo(x, y, r)
    self.x = x or self.x
    self.y = y or self.y
    self.r = r or self.r
end

function Deck:shuffleCards()
    local new = {}

    while #self.cards > 0 do
        insert(new, remove(self.cards, random(1, #self.cards)))
    end

    self.cards = new
end

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

set(Deck, {__call = Deck.initialize})
return Deck
