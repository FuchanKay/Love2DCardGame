CardScene = {}
Createobj = require 'createobj'
local windowWidth = 1540
local windowHeight = 840
local LEFT_CLICK = 1
local RIGHT_CLICK = 2
local printCardStats = false
CardScene.load = function()
    Selected = false
    SelectedCard = nil
    HasSelectedCard = false
    Deposits = {}
    Deposits[#Deposits + 1] = Createobj.deposit(400, 400)       
    Cards = {}
end

CardScene.update = function()
    local stopChecking = false
    for i = 1, #Cards do
        local card = Cards[#Cards + 1 - i]

        local isHovered = IsBeingHovered(card)
        if Selected and isHovered and not HasSelectedCard and not stopChecking and not card.isMovingToDeposit then
            card.selected = true
            SelectedCard = card
            HasSelectedCard = true
            card.mouseOffsetX = MouseX - card.x
            card.mouseOffsetY = MouseY - card.y
            table.remove(Cards, #Cards + 1 - i)
            table.insert(Cards, card)
            Selected = false
            stopChecking = true
        end
        card.update()
        if not card.isAlive then
            table.remove(Cards, #Cards + 1 - i)
        end
    end
    if printCardStats then
        print(#Cards)
    end
    printCardStats = false
    local noDepositsSelected = true
    for i = 1, #Deposits do
        local deposit = Deposits[#Deposits + 1 - i]
        if HasSelectedCard and Selected and IsBeingHovered(deposit) then
            SelectedCard.moveToDeposit(deposit)
            SelectedCard.selected = false
            deposit.add(SelectedCard)
            HasSelectedCard = false
            noDepositsSelected = false
            break
        end
    end

    if HasSelectedCard and Selected and noDepositsSelected then
        SelectedCard.moveToMouse(MouseX, MouseY)
        HasSelectedCard = false
        SelectedCard.selected = false
        SelectedCard = nil
    end
    Selected = false
end

CardScene.draw = function()
    love.graphics.setShader(shader)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
    for i, deposit in ipairs(Deposits) do
        deposit.draw()
    end
    for i, card in ipairs(Cards) do
        card.draw()
    end

end
CardScene.keyboardpressed = function(k)
    if k == "s" then
        CurrentScene = Scenes.newScene
    end
    if k == "p" then
        printCardStats = true
    end
end

CardScene.keyboardreleased = function(k)

end

CardScene.mousepressed = function(x, y, button)
    if button == LEFT_CLICK then
        Selected = true
    end
end

CardScene.mousereleased = function(x, y, button, istouch, presses)
    if button == RIGHT_CLICK then
        Cards[#Cards + 1] = Createobj.card(x, y)
    end

end

function Swap(Table, Pos1, Pos2)
    local tmp = Table[Pos1]
    Table[Pos1] = Table[Pos2]
    Table[Pos2] = tmp
    return Table
end

function IsBeingHovered(obj)
    local withinX = MouseX >= obj.x - obj.spriteWidth / 2 and MouseX <= obj.x + obj.spriteWidth / 2
    local withinY = MouseY >= obj.y - obj.spriteHeight / 2 and MouseY <= obj.y + obj.spriteHeight / 2
    return withinX and withinY
end

function IsColliding(obj1, obj2)
    local collidingX = obj1.x - obj1.spriteWidth / 2 > obj2.x + obj2.spriteWidth / 2 or obj1.x + obj1.spriteWidth / 2 < obj2.x - obj2.spriteWidth / 2
    local collidingY = obj1.y - obj1.spriteHeight / 2 > obj2.y + obj2.spriteHeight / 2 or obj2.y + obj2.spriteHeight / 2 < obj2.y - obj2.spriteHeight / 2
    return collidingX and collidingY
end

return CardScene