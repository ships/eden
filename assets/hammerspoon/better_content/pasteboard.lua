local pb = {}

function pb.typeKeys()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end

return pb
