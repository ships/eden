local mainFrame = function(win)
  local max = win:screen():frame()
  max.x = max.x + max.w * 2/7
  max.w = max.w * 5/7
  return max
end

local trayFrame = function(win)
  local max = win:screen():frame()
  max.w = max.w * 2/7
  return max
end

tray_0 = function()
  local win = hs.window.focusedWindow()
  win:setFrame(trayFrame(win))
end

rmain = function()
  local win = hs.window.focusedWindow()
  win:setFrame(mainFrame(win))
end

local setWithRegion = function(reg)
  win = hs.window.focusedWindow()
  win:setFrame(reg(mainFrame(win)))
end

rleft = function()
  setWithRegion(lsplit)
end

rright = function()
  setWithRegion(rsplit)
end

rtop = function()
  setWithRegion(tsplit)
end

rbottom = function()
  setWithRegion(bsplit)
end
