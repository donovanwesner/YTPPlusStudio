return {
    Version = {
        Major = 0,
        Minor = 1,
        Patch = 0,
        Label = "publictestbuild",
        Candidate = 1
    },
    --window options
    Width = 320,
    Height = 240,
    WindowFlags = {
        fullscreen = false,
        fullscreentype = "desktop",
        vsync = 1,
        msaa = 0,
        stencil = true,
        depth = 0,
        resizable = false,
        borderless = false,
        centered = true,
        display = 1,
        minwidth = 320,
        minheight = 240
    },
    BackgroundSize = 28,
    --fade types
    FadeNone = nil,
    FadeOut = 0,
    FadeIn = 1,
    --screens
    Menu = 0,
    Generate = 1,
    Plugins = 2,
    Options = 3,
    ScreenNames = {
        "generate",
        "plugins",
        "options"
    }
}