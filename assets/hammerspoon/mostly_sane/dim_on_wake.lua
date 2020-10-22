local dim = {}

function dim_watcher_callback(event)
    if event == hs.caffeinate.watcher.systemDidWake then
	local dev = hs.screen.primaryScreen()
	dev:setBrightness(0.1)
    end
end

function dim.enable()
    ms.dim_on_wake_watcher = hs.caffeinate.watcher.new(dim_watcher_callback)
    ms.dim_on_wake_watcher:start()
end

return dim
