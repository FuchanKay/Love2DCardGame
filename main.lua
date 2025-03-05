local settings = require 'settings'
local shaderCode = [[
vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screenCoords) {
    vec4 pixel = Texel(image, uvs);
    return pixel * color;
}
]]
local LEFT_CLICK = 1
local RIGHT_CLICK = 2

function love.load()
    anim8 = require 'libraries.anim8'
    cards = {}
    cards.hasSelectedCard = false
    love.window.setTitle("Fuma Card")
    love.window.setMode(settings.windowWidth, settings.windowHeight)
    shader = love.graphics.newShader(shaderCode)
    scenes = {}
    scenes.cardScene = require 'card_scene'
    currentScene = scenes.cardScene
end

local t = 0
function love.update(dt)
    currentScene.update()
    t = t + dt
    -- effect:send("time", t)
end

function love.draw()
    currentScene.draw()
end

function love.keypressed(k)
    if k == "r" then love.event.quit "restart" end
    currentScene.keyboardpressed(k)
end

function love.keyreleased(k)
    currentScene.keyboardreleased(k)
end

function love.mousepressed(x, y, button)
    currentScene.mousepressed(button)
end

function love.mousereleased(x, y, button, istouch, presses)
    currentScene.mousereleased(x, y, button, istouch, presses)
end

function UpdateGlobals()
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end
