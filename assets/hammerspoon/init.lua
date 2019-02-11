rzero = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 2 / 7
  f.h = max.h
  win:setFrame(f)
end

rmax = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2 / 7
  f.y = max.y
  f.w = max.w * 5 / 7
  f.h = max.h
  win:setFrame(f)
end

rone = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 9 / 14
  f.y = max.y
  f.w = max.w * 5 / 14
  f.h = max.h / 2
  win:setFrame(f)
end

rtwo = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2 / 7
  f.y = max.y
  f.w = max.w * 5 / 14
  f.h = max.h / 2
  win:setFrame(f)
end

rthree = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2 / 7
  f.y = max.y + max.h / 2
  f.w = max.w * 5 / 14
  f.h = max.h / 2
  win:setFrame(f)
end

rfour = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 9 / 14
  f.y = max.y + max.h / 2
  f.w = max.w * 5 / 14
  f.h = max.h / 2
  win:setFrame(f)
end

rleft = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2/7
  f.y = max.y
  f.w = max.w * 5 / 14
  f.h = max.h
  win:setFrame(f)
end

rright = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 9 / 14
  f.y = max.y
  f.w = max.w * 5 / 14
  f.h = max.h
  win:setFrame(f)
end

rtop = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2 / 7
  f.y = max.y
  f.w = max.w * 5/7
  f.h = max.h / 2
  win:setFrame(f)
end

rbottom = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * 2 / 7
  f.y = max.y + max.h / 2
  f.w = max.w * 5/7
  f.h = max.h / 2
  win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "0", rzero)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "M", rmax)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "1", rone)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "2", rtwo)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "3", rthree)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "4", rfour)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", rleft)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", rright)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Up", rtop)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Down", rbottom)
