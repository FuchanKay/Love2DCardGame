local deposit = {}
function deposit.new(x, y)
    self = {}
    self.x = x
    self.y = y
    self.sprite = love.graphics.newImage('res/no.png')
    self.spriteWidth = self.sprite:getWidth()
    self.spriteHeight = self.sprite:getHeight()

    self.storage = {}
    local font = love.graphics.getFont()
    local counter = love.graphics.newText(font, #self.storage)

    self.draw = function()
        love.graphics.draw(self.sprite, self.x - self.spriteWidth / 2, self.y - self.spriteHeight / 2)
        love.graphics.draw(counter, self.x, self.y)
    end

    self.add = function(obj) 
        self.storage[#self.storage + 1] = obj
        counter = love.graphics.newText(font, #self.storage)
    end

    self.update = function()

    end
    return self
end
return deposit