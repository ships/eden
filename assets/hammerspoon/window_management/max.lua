local WIDE_COLS = 5
local NORMAL_COLS = 3

local maxFrame = function(win)
  return win:screen():frame()
end

local setWithRegion = function(reg)
  win = hs.window.focusedWindow()
  win:setFrame(reg(maxFrame(win)))
end

xone = function()
  setWithRegion(q1)
end

xtwo = function()
  setWithRegion(q2)
end

xthree = function()
  setWithRegion(q3)
end

xfour = function()
  setWithRegion(q4)
end

max_M = function()
  local win = hs.window.focusedWindow()
  win:setFrame(maxFrame(win))
end


tray_1 = function()
  setWithRegion(column(NORMAL_COLS, 0, 1))
end
tray_3 = function()
  setWithRegion(column(NORMAL_COLS, 1, 1))
end
tray_5 = function()
  setWithRegion(column(NORMAL_COLS, 2, 1))
end

-- not yet clear what these should do
tray_2 = function()
  -- setWithRegion(column(NORMAL_COLS, 0, 1))
end

tray_4 = function()
  -- setWithRegion(column(NORMAL_COLS, 4, 1))
end


max_0 = function()
  setWithRegion(column(4, 1, 2))
end
max_1 = function()
  setWithRegion(column(WIDE_COLS, 0, 1))
end
max_2 = function()
  setWithRegion(column(WIDE_COLS, 1, 1))
end
max_3 = function()
  setWithRegion(column(WIDE_COLS, 2, 1))
end
max_4 = function()
  setWithRegion(column(WIDE_COLS, 3, 1))
end
max_5 = function()
  setWithRegion(column(WIDE_COLS, 4, 1))
end

max_L = function()
  setWithRegion(lsplit)
end

max_R = function()
  setWithRegion(rsplit)
end

max_UP = function()
  setWithRegion(tsplit)
end

max_DN = function()
  setWithRegion(bsplit)
end
