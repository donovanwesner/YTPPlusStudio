function love.load()
    Audio = require("audio")
    Graphics = require("gfx")
    Enums = require("enums")
    Data = require("data")
    Canvas = love.graphics.newCanvas(Enums.Width,Enums.Height)
    Canvas:setFilter("nearest", "nearest")
    Main = {
        Boot = 0,
        LastScreen = Enums.Menu,
        ActiveScreen = Enums.Menu,
        NextScreen = Enums.Menu,
        Fade = Enums.FadeNone,
        ScreenWait = 0,
        W = 0,
        X = 0,
        Y = 0,
        Flip = 0,
        Flipping = false
    }
    love.window.setMode( Enums.Width*Data.Scaling, Enums.Height*Data.Scaling, Enums.WindowFlags )
    love.mouse.setCursor( Graphics.Cursor )
    Audio.Boot:play()
end
function love.draw()
    love.graphics.setCanvas(Canvas) --This sets the draw target to the canvas
    love.graphics.clear()
    love.graphics.setBackgroundColor(0.25,0.25,0.25,Main.Boot) --#404040
    --tiled background
    love.graphics.setColor(0.4,0.4,0.4)
    love.graphics.draw(Graphics.Tiles, Graphics.TiledQuad, Main.X - Enums.BackgroundSize, Main.Y - Enums.BackgroundSize) --bottom left corner
    love.graphics.draw(Graphics.Tiles, Graphics.TiledQuad, Main.X + Enums.BackgroundSize, Main.Y + Enums.BackgroundSize) --top right corner
    love.graphics.draw(Graphics.Tiles, Graphics.TiledQuad, Main.X + Enums.BackgroundSize, Main.Y - Enums.BackgroundSize) --bottom left corner
    love.graphics.draw(Graphics.Tiles, Graphics.TiledQuad, Main.X - Enums.BackgroundSize, Main.Y + Enums.BackgroundSize) --top left corner
    --end bg
    love.graphics.setColor(0,0,0,Main.Boot)
    love.graphics.rectangle("fill",2,2,Enums.Width-4,17) --title bar
    --these are all parameters for the border around the screen:
    love.graphics.setColor(0.5,0.5,0.5,Main.Boot)
    love.graphics.rectangle("fill",0,0,2,Enums.Height)
    love.graphics.rectangle("fill",Enums.Width-2,0,2,Enums.Height)
    love.graphics.rectangle("fill",1,0,Enums.Width-2,2)
    love.graphics.rectangle("fill",1,Enums.Height-2,Enums.Width-2,2)
    --end border
    if Main.ActiveScreen ~= Enums.Menu then
        --header
        love.graphics.setColor(1,1,1) --#FFFFFF
        love.graphics.setFont(Graphics.Munro.Regular)
        love.graphics.printf(Enums.ScreenNames[Main.ActiveScreen], 0, 6-3, Enums.Width, "center")
        --back button
        love.graphics.setColor(0.5,0.5,0.5)
        love.graphics.rectangle("fill",2,2,17,17)
        love.graphics.setColor(1,1,1)
        love.graphics.draw(Graphics.Back,2,2)
        --end back button
        --draw screen types
    else --menu
        --header
        love.graphics.setColor(1,1,1,Main.Boot) --white with boot sequence as its transparency
        love.graphics.draw(Graphics.Icon, 129+Graphics.Icon:getWidth()/2,4+Graphics.Icon:getHeight()/2, Main.Flip, 1, 1, Graphics.Icon:getWidth()/2, Graphics.Icon:getHeight()/2) --this icon is positioned by its center and rotates that way
        love.graphics.setFont(Graphics.Munro.Regular)
        love.graphics.print("ytp+ studio",146,6-3) --minus 3 due to font scaling
        --buttons
        love.graphics.print("generate\n\nplugins\n\noptions\n\nquit",22,89-3) --main menu, not centered, \n means new line
    end
    --fading
    love.graphics.setColor(1,1,1,Main.ScreenWait)
    love.graphics.rectangle("fill",0,0,Enums.Width,Enums.Height)
    --color tint, commented for later functionality
    --[[
    love.graphics.setColor(1,0,1,0.1) --pinkish?
    love.graphics.rectangle("fill",0,0,Enums.Width,Enums.Height)
    ]]
    love.graphics.setCanvas() --This sets the target back to the screen
    love.graphics.setColor(1,1,1,Main.Boot) --#FFFFFF
    love.graphics.draw(Canvas, 0, 0, 0, Data.Scaling, Data.Scaling)
end
function love.update()
    if Main.Boot < 1 then --boot sequence
        Main.Boot = Main.Boot + 0.005 --despacito
    end
    --screen change fading
    if Main.Fade == Enums.FadeOut and Main.ScreenWait < 1 then --fade to white
        Main.ScreenWait = Main.ScreenWait + 0.1
    elseif Main.Fade == Enums.FadeOut then --begin fade in and change to new screen
        Main.Fade = Enums.FadeIn
        Main.LastScreen = Main.ActiveScreen
        Main.ActiveScreen = Main.NextScreen
    end
    if Main.Fade == Enums.FadeIn and Main.ScreenWait > 0 then --fade out from white into new screen
        Main.ScreenWait = Main.ScreenWait - 0.1
    elseif Main.Fade == Enums.FadeIn then --fade over
        Main.ScreenWait = 0
        Main.Fade = Enums.FadeNone
    end
    -- scrolling bg and flipping
    Main.W = Main.W + 1
    if Main.W == 3 then --slow down animations so they're not too fast
        if Main.Flipping == true and Main.Flip > -10 then --logo flip
            Main.Flip = Main.Flip - 1
        elseif Main.Flip == -10 then --that's enough flipping
            Main.Flipping = false
            Main.Flip = 0
            Audio.Back:play()
        end
        Main.X = Main.X + 1
        Main.Y = Main.Y + 1
        Main.W = 0
    end
    if Main.X >= Enums.BackgroundSize then Main.X = 0 end --reset to original x flawlessly
    if Main.Y >= Enums.BackgroundSize then Main.Y = 0 end --ditto with y
end
function love.mousepressed( x, y, button, istouch, presses )
    Main.Boot = 1 --disable boot sequence
    x = x/Data.Scaling --scale up mouse x
    y = y/Data.Scaling --ditto with y
    if Main.ActiveScreen == Enums.Menu then
        if x >= 22 and y >= 89 and x < 58 and y < 98 then --generate
            Main.NextScreen = Enums.Generate
            Main.Fade = Enums.FadeOut
            Audio.Select:play()
        elseif x >= 22 and y >= 113 and x < 49 and y < 122 then --plugins
            Main.NextScreen = Enums.Plugins
            Main.Fade = Enums.FadeOut
            Audio.Select:play()
        elseif x >= 22 and y >= 137 and x < 51 and y < 146 then --options
            Main.NextScreen = Enums.Options
            Main.Fade = Enums.FadeOut
            Audio.Select:play()
        elseif x >= 129 and y >= 4 and x < 142 and y < 17 and Main.Flipping == false then --cool logo flip
            Main.Flipping = true
            Audio.Select:play()
        elseif x >= 22 and y >= 161 and x < 37 and y < 170 then --quit
            love.event.quit()
        else
            Audio.Hover:play()
        end
    elseif x >= 2 and y >= 2 and x < 19 and y < 19 then --back button
        Main.NextScreen = Main.LastScreen
        Main.Fade = Enums.FadeOut
        Audio.Back:play()
    end
end
function love.keypressed(k)
    --alt operators
    if love.keyboard.isDown("ralt") or love.keyboard.isDown("lalt") then
        if k == "left" and Main.ActiveScreen ~= Enums.Menu then --back, same as pressing the button
            Main.NextScreen = Main.LastScreen
            Main.Fade = Enums.FadeOut
            Audio.Back:play()
        end
        --up and down buttons removed because they can break submenus
        --[[elseif k == "up" and Main.ActiveScreen - 1 >= Enums.Menu and Main.ActiveScreen ~= Enums.Menu then --up
            Main.NextScreen = Main.ActiveScreen - 1
            Main.Fade = Enums.FadeOut
            Audio.Select:play()
        elseif k == "down" and Main.ActiveScreen + 1 < Enums.LastScreen then --down
            Main.NextScreen = Main.ActiveScreen + 1
            Main.Fade = Enums.FadeOut
            Audio.Select:play()
        end]]
    end
end
