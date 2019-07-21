local mute = {}

function mute_watcher_callback(event)
    if event == hs.caffeinate.watcher.systemDidWake then
			local dev = hs.audiodevice.defaultOutputDevice()
			dev:setMuted(true)
    end
end

function mute.enable()
    ms.mute_on_wake_watcher = hs.caffeinate.watcher.new(mute_watcher_callback)
    ms.mute_on_wake_watcher:start()
end

return mute
