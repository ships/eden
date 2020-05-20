centerCursor = function()
  local win = hs.window.focusedWindow()
  local pt = win:frame().center
  hs.mouse.setAbsolutePosition(pt)
end
