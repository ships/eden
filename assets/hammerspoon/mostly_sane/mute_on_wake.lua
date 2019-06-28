ms = {}

function f(event)
    if event == hs.caffeinate.watcher.systemDidWake then
			local dev = hs.audiodevice.defaultOutputDevice()
			dev:setMuted(true)
    end
end

function ms.mute_on_wake()
    ms.mute_on_wake_watcher = hs.caffeinate.watcher.new(f)
    ms.mute_on_wake_watcher:start()
end

return ms
