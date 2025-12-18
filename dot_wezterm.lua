-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Font size (WezTerm bundles JetBrains Mono by default)
config.font_size = 14.0

-- Cleaner window (removes title bar, keeps resize handles)
config.window_decorations = "RESIZE"

-- Bigger scrollback buffer
config.scrollback_lines = 10000

-- Quick select patterns (Ctrl+Shift+Space to activate)
config.quick_select_patterns = {
  '[0-9a-f]{7,40}',  -- git hashes
  '[a-zA-Z0-9._/-]+\\.[a-zA-Z0-9]+',  -- file paths with extensions
}

-- Color scheme:
config.color_scheme = 'Gruvbox Material (Gogh)'

-- Override dim/secondary color to be more visible (ANSI bright black, color 8)
-- This makes file paths and secondary text in CLI tools more readable
-- WezTerm requires all 8 bright colors to be defined
config.colors = {
  brights = {
    "#7c6f64",  -- Color 8 (bright black/dim) - Visible but clearly dimmer than main text
    "#fb4934",  -- Color 9 (bright red)
    "#b8bb26",  -- Color 10 (bright green)
    "#fabd2f",  -- Color 11 (bright yellow)
    "#83a598",  -- Color 12 (bright blue)
    "#d3869b",  -- Color 13 (bright magenta)
    "#8ec07c",  -- Color 14 (bright cyan)
    "#ebdbb2",  -- Color 15 (bright white)
  },
}

local act = wezterm.action

config.keys = {
	{ key = '{', mods = 'SHIFT|OPT', action = act.MoveTabRelative(-1) },
	{ key = '}', mods = 'SHIFT|OPT', action = act.MoveTabRelative(1) },
	{ key = 'Enter', mods = 'SHIFT', action = wezterm.action{SendString="\x1b\r"} },
}

-- and finally, return the configuration to wezterm
return config
