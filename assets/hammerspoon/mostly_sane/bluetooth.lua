local bt = {}

function bluetooth_watcher_callback(event)
    if event == hs.caffeinate.watcher.systemWillSleep then
	local disableTask = hs.task.new("/usr/local/bin/blueutil", nil, {"-p", "0"})
	disableTask:start()
    end
end

function bt.enable()
    ms.bt_watcher = hs.caffeinate.watcher.new(bluetooth_watcher_callback)
    ms.bt_watcher:start()
end

function bt.toggle_command()
    local disableTask = hs.task.new("/usr/local/bin/blueutil", nil, {"-p", "toggle"})
    disableTask:start()
end

return bt
