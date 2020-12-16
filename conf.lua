function love.conf(t)
    local Enums = require("enums") --conf enums
    t.window.title = "YTP+ Studio"
    t.window.width = Enums.Width
    t.window.height = Enums.Height
    t.window.icon = "logo.png"
end
