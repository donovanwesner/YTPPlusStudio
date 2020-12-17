function love.conf(t)
    local Enums = require("enums") --conf enums
    local ver = Enums.Version.Major.."."..Enums.Version.Minor.."."..Enums.Version.Patch
    if Enums.Version.Label ~= nil then ver = ver.."-"..Enums.Version.Label.."."..Enums.Version.Candidate end
    local path = love.filesystem.getSource()
    if string.find(path, ".love") or string.find(path, ".exe") then
        t.window.title = "ytp+ studio [v"..ver.."]"
    else
        t.window.title = "ytp+ studio [under construction]"
    end
    t.window.width = Enums.Width
    t.window.height = Enums.Height
    t.window.icon = "logo.png"
end
