local dim = {}

function dim_watcher_callback(event)
  if event == hs.caffeinate.watcher.systemDidWake then
    local ss = hs.screen.allScreens()

    for i,s in ipairs(ss) do
      local n = s:name()
      local f = n:find("Retina Display")
      if f then
        s:setBrightness(0.1)
      else
        print("Screen was called: " .. n .. "; found=", f)
      end
    end
  end
end

function dim.enable()
    ms.dim_on_wake_watcher = hs.caffeinate.watcher.new(dim_watcher_callback)
    ms.dim_on_wake_watcher:start()
end

return dim
