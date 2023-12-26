-- Wezterm config based on https://wezfurlong.org/wezterm/config/files.html
--
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- This is where you actually apply your config choices

-- Color scheme
config.color_scheme = 'Pixiefloss (Gogh)'

-- Fonts
config.font = wezterm.font 'SauceCodePro Nerd Font'

-- and finally, return the configuration to wezterm
return config
