local tiles = love.graphics.newImage("graphics/tile.png")
local Enums = require("enums")
tiles:setWrap("repeat", "repeat")
return {
    Icon = love.graphics.newImage( "graphics/icon.png" ),
    IconFlipped = love.graphics.newImage( "graphics/icon-export.png" ),
    Back = love.graphics.newImage( "graphics/backbutton.png" ),
    Tiles = tiles,
    TiledQuad = love.graphics.newQuad(0, 0, Enums.Width, Enums.Height, tiles:getWidth(), tiles:getHeight()),
    Munro = {
        Regular = love.graphics.newFont("fonts/munro.ttf", 10, "mono"),
        Small = love.graphics.newFont("fonts/munro-small.ttf", 10, "mono"),
        Narrow = love.graphics.newFont("fonts/munro-narrow.ttf", 10, "mono")
    },
    Cursor = love.mouse.newCursor( love.image.newImageData( "graphics/cursor.png" ), 0, 0 )
}
