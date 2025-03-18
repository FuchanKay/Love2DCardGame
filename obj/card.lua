local card = {}

function card.new(x, y)
    local self = {}
    self.x = x
    self.y = y
    self.isAlive = true

    self.sprite = love.graphics.newImage('res/card.png')
    self.spriteWidth = self.sprite:getWidth()
    self.spriteHeight = self.sprite:getHeight()

    self.speedFactor = 0.1
    self.expandFactor = 1.075

    self.mouseOffsetX = nil
    self.mouseOffsetY = nil
    self.selected = false

    self.draw = function()
        if not self.selected then
            love.graphics.draw(self.sprite, self.x - self.spriteWidth / 2, self.y - self.spriteHeight / 2)
        else
            local drawX = self.x - (self.expandFactor * self.spriteWidth / 2)
            local drawY = self.y - (self.expandFactor * self.spriteHeight / 2)
            love.graphics.draw(self.sprite, drawX, drawY, 0, self.expandFactor, self.expandFactor)
        end
    end

    self.moveToX = self.x
    self.moveToY = self.y
    self.isMovingToMouse = false
    self.isMovingToDeposit = false
    local margin = 5

    self.moveToMouse = function(xCoord, yCoord)
        self.moveToX = xCoord
        self.moveToY = yCoord
        self.isMovingToMouse = true
    end
    
    self.moveToDeposit = function(deposit)
        self.moveToX = deposit.x
        self.moveToY = deposit.y
        self.isMovingToDeposit = true
    end

    self.kill = function()
        self.isAlive = false
    end

    self.update = function()
        local velX = (self.moveToX - self.x) * self.speedFactor
        local velY = (self.moveToY - self.y) * self.speedFactor
        if self.isMovingToMouse or self.isMovingToDeposit then
            self.x = self.x + velX
            self.y = self.y + velY
        end
        local withinMargin = math.abs(velX / self.speedFactor) <= margin and math.abs(velY / self.speedFactor) <= margin
        if withinMargin then
            if self.isMovingToMouse then
                self.isMovingToMouse = false
            elseif self.isMovingToDeposit then
                self.isMovingToDeposit = false
                self.isAlive = false
            end
        end
    end
    return self
end
return card