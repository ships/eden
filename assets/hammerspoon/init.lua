maxFrame = function(win)
  return win:screen():frame()
end

mainFrame = function(win)
  local max = maxFrame(win)
  max.x = max.x + max.w * 2/7
  max.w = max.w * 5/7
  return max
end

trayFrame = function(win)
  local max = maxFrame(win)
  max.w = max.w * 2/7
  return max
end

rzero = function()
  local win = hs.window.focusedWindow()
  local tray = trayFrame(win)

  win:setFrame(tray)
end

rmain = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  win:setFrame(max)
end

rone = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x + max.w / 2
  max.y = max.y
  max.w = max.w / 2
  max.h = max.h / 2
  win:setFrame(max)
end

rtwo = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x
  max.y = max.y
  max.w = max.w / 2
  max.h = max.h / 2
  win:setFrame(max)
end

rthree = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x
  max.y = max.y + max.h / 2
  max.w = max.w / 2
  max.h = max.h / 2
  win:setFrame(max)
end

rfour = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x + max.w / 2
  max.y = max.y + max.h / 2
  max.w = max.w / 2
  max.h = max.h / 2
  win:setFrame(max)
end

rleft = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x
  max.y = max.y
  max.w = max.w / 2
  max.h = max.h
  win:setFrame(max)
end

rright = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x + max.w / 2
  max.y = max.y
  max.w = max.w / 2
  max.h = max.h
  win:setFrame(max)
end

rtop = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x
  max.y = max.y
  max.w = max.w
  max.h = max.h / 2
  win:setFrame(max)
end

rbottom = function()
  local win = hs.window.focusedWindow()
  local max = mainFrame(win)

  max.x = max.x
  max.y = max.y + max.h / 2
  max.w = max.w
  max.h = max.h / 2
  win:setFrame(max)
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
