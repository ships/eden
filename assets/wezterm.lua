-- Wezterm config based on https://wezfurlong.org/wezterm/config/files.html
--
-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

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
config.font_size = 14.0

-- keymap
config.keys = {
  -- Pipe to split vertical
  {
    key = '\\',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- dash to split horizontal
  {
    key = '-',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CTRL|ALT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\x1bb' },
  -- Make Option-Right equivalent to Alt-f; forward-word
  { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },
}

-- and finally, return the configuration to wezterm
return config
