require("lib/TSerial")
local data = {
    Scaling = 2
}
local info = love.filesystem.getInfo("settings.txt")
if not info then --does not exist
    love.filesystem.write("settings.txt", "{}")
end
local unpack = TSerial.unpack(love.filesystem.read("settings.txt"), true)
for k,v in pairs(unpack) do data[k] = v end --combine data and unpack tables
return data
