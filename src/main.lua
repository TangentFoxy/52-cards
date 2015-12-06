math.randomseed(os.time())
local Deck = require "Deck"
local Card = require "Card"
local insert = table.insert

local items = {}

local inspect = require "lib.inspect" --NOTE DEBUG

local function makeDeck(jokers)
    local cards = {}
    local suits = {"Clubs", "Diamonds", "Hearts", "Spades"}
    local ranks = {"Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"}

    for _, suit in ipairs(suits) do
        for _, rank in ipairs(ranks) do
            insert(cards, Card(suit, rank))
        end
    end

    if jokers then
        insert(cards, Card("", "Joker"))
        insert(cards, Card("", "Joker"))
    end

    print(inspect(cards)) --NOTE DEBUG
    print(inspect(cards[1].suit))

    return Deck(cards)
end

function love.load()
    insert(items, makeDeck(true))
    items[1]:shuffleCards()
    items[1]:moveTo(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
end

function love.draw()
    for i=1,#items do
        items[i]:draw()
    end
end

-- ♣ ♦ ♥ ♠ A 2 3 4 5 6 7 8 9 10 J Q K Joker
