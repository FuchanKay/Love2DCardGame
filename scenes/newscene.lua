CardScene = {}
Createobj = require 'createobj'
local windowWidth = 1540
local windowHeight = 840
local LEFT_CLICK = 1
local RIGHT_CLICK = 2

CardScene.load = function()
    Selected = false
    SelectedCard = nil
    HasSelectedCard = false
    NewDeposit = Createobj.deposit(400, 400)
    Cards = {}
end

CardScene.update = function()
    for i = 1, #Cards do
        local card = Cards[#Cards + 1 - i]
        local cardWidth = card.sprite:getWidth()
        local cardHeight = card.sprite:getHeight()
        local withinX = MouseX >= card.x - cardWidth / 2 and MouseX <= card.x + cardWidth / 2
        local withinY = MouseY >= card.y - cardHeight / 2 and MouseY <= card.y + cardHeight / 2
        if Selected and withinX and withinY and not HasSelectedCard then
            SelectedCard = card
            SelectedCard.selected = true
            HasSelectedCard = true
            SelectedCard.mouseOffsetX = MouseX - card.x
            SelectedCard.mouseOffsetY = MouseY - card.y
            table.insert(Cards, SelectedCard)
            Selected = false
            break
        end
    end

    if HasSelectedCard then
        local velX = MouseX - SelectedCard.x - SelectedCard.mouseOffsetX
        local velY = MouseY - SelectedCard.y - SelectedCard.mouseOffsetY
        velX = velX * SelectedCard.speedFactor
        velY = velY * SelectedCard.speedFactor
        SelectedCard.x = SelectedCard.x + velX
        SelectedCard.y = SelectedCard.y + velY
    end

    if HasSelectedCard and Selected then
        HasSelectedCard = false
        SelectedCard.selected = false;
        SelectedCard = nil
    end

    Selected = false

end

CardScene.draw = function()
    -- love.graphics.setShader(shader)
    -- love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
    -- for i, card in ipairs(Cards) do
    --     card.draw()
    -- end
    -- NewDeposit.draw()
end

CardScene.keyboardpressed = function(k)
    if k == "s" then
        CurrentScene = Scenes.cardScene
    end
end

CardScene.keyboardreleased = function(k)

end

CardScene.mousepressed = function(x, y, button)

end

CardScene.mousereleased = function(x, y, button, istouch, presses)
    if button == RIGHT_CLICK then
        Cards[#Cards + 1] = Createobj.card(x, y)
    end
    if button == LEFT_CLICK then 
        Selected = true
    end
end

function Swap(Table, Pos1, Pos2)
    local tmp = Table[Pos1]
    Table[Pos1] = Table[Pos2]
    Table[Pos2] = tmp
    return Table
end

return CardScene