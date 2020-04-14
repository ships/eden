moveToNext = function()
  local win = hs.window.focusedWindow()
  local current = hs.screen.mainScreen()
  local nextscr = current:next()
  win:setFrame(nextscr:frame())
end

moveToPrev = function()
  local win = hs.window.focusedWindow()
  local current = hs.screen.mainScreen()
  local nextscr = current:previous()
  win:setFrame(nextscr:frame())
end
