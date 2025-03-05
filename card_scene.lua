cardScene = {}
local windowWidth = 1540
local windowHeight = 840
local LEFT_CLICK = 1
local RIGHT_CLICK = 2
cardScene.load = function()

end
cardScene.update = function()
    UpdateGlobals()
    for i = 1, #cards do
        local card = cards[#cards + 1 - i]
        local cardWidth = card.sprite:getWidth()
        local cardHeight = card.sprite:getHeight()
        local isDown = love.mouse.isDown(LEFT_CLICK)
        local withinX = mouseX >= card.x - cardWidth / 2 and mouseX <= card.x + cardWidth / 2
        local withinY = mouseY >= card.y - cardHeight / 2 and mouseY <= card.y + cardHeight / 2
        if not isDown then
            card.isSelected = false
            cards.hasSelectedCard = false
        end
        if withinX and withinY and isDown and not cards.hasSelectedCard then
            table.insert(cards, card)
            card.mouseOffsetX = mouseX - card.x
            card.mouseOffsetY = mouseY - card.y
            card.isSelected = true
            card.selectAnimation = true
            cards.hasSelectedCard = true
        end
        if card.isSelected then
            local velX = mouseX - card.x - card.mouseOffsetX
            local velY = mouseY - card.y - card.mouseOffsetY
            velX = velX * card.speedFactor
            velY = velY * card.speedFactor
            card.x = card.x + velX
            card.y = card.y + velY
            break
        end
    end
end
cardScene.draw = function()
    love.graphics.setShader(shader)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
    for i, card in ipairs(cards) do
        local cardWidth = card.sprite:getWidth()
        local cardHeight = card.sprite:getHeight()
        if card.selectAnimation then
            love.graphics.draw(card.sprite,
                card.x - cardWidth * card.expandFactor / 2, card.y - cardHeight * card.expandFactor / 2,
                0, card.expandFactor, card.expandFactor)
            card.selectAnimation = false
        else
            love.graphics.draw(card.sprite, card.x - cardWidth / 2, card.y - cardHeight / 2)
        end
    end
end
cardScene.keyboardpressed = function(k)
    if k == "s" then
        
    end
end
cardScene.keyboardreleased = function(k)

end
cardScene.mousepressed = function(x, y, button)

end
cardScene.mousereleased = function(x, y, button, istouch, presses)
    if button == RIGHT_CLICK then
        cards[#cards + 1] = CreateCard(x, y)
    end
end
function CreateCard(x, y)
    local card = {}
    card.x = x
    card.y = y
    card.sprite = love.graphics.newImage('res/card.png')
    card.speedFactor = 0.25
    card.isSelected = false
    card.selectAnimation = false
    card.expandFactor = 1.05
    card.mouseOffsetX = nil
    card.mouseOffsetY = nil
    return card
end

function Swap(Table, Pos1, Pos2)
    local tmp = Table[Pos1]
    Table[Pos1] = Table[Pos2]
    Table[Pos2] = tmp
    return Table
end

return cardScene
