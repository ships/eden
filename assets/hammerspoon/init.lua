dofile("./window_management/geometry.lua")
dofile("./window_management/tray.lua")
dofile("./window_management/max.lua")

maxFrame = function(win)
  return win:screen():frame()
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "0", rzero)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "M", rmain)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "1", rone)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "2", rtwo)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "3", rthree)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "4", rfour)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", rleft)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", rright)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Up", rtop)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Down", rbottom)
