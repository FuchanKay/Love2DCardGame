local settings = require 'settings'
local shaderCode = [[
vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screenCoords) {
    vec4 pixel = Texel(image, uvs);
    return pixel * color;
}
]]
LEFT_CLICK = 1
RIGHT_CLICK = 2

function love.load()
    MouseX = 0
    MouseY = 0
    anim8 = require 'libraries.anim8'
    love.window.setTitle("Fuma Card")
    love.window.setMode(settings.windowWidth, settings.windowHeight)
    shader = love.graphics.newShader(shaderCode)
    Scenes = {}
    Scenes.cardScene = require 'scenes.cardscene'
    Scenes.newScene = require 'scenes.newscene'
    CurrentScene = Scenes.cardScene
    CurrentScene.load()
end

local t = 0
function love.update(dt)
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()
    CurrentScene.update()
    t = t + dt
    -- effect:send("time", t)
end

function love.draw()
    CurrentScene.draw()
end

function love.keypressed(k)
    if k == "r" then love.event.quit "restart" end
    CurrentScene.keyboardpressed(k)
end

function love.keyreleased(k)
    CurrentScene.keyboardreleased(k)
end

function love.mousepressed(x, y, button)
    MouseX = x
    MouseY = y
    CurrentScene.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button, istouch, presses)
    CurrentScene.mousereleased(x, y, button, istouch, presses)
end
