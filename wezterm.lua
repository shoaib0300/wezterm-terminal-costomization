local wezterm = require "wezterm"
local config = wezterm.config_builder()
config.default_prog = { "/usr/bin/zsh", "-l" }

-- Fonts
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Fira Code",
})
config.font_size = 13.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- IMPORTANT: keep window buttons (min/max/close)
config.window_decorations = "TITLE | RESIZE"

-- Core look
config.enable_scroll_bar = false
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_background_opacity = 0.80

-- Cursor “laser”
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 450
config.keys = config.keys or {}

table.insert(config.keys, {
  key = "A",
  mods = "CTRL|SHIFT",
  action = wezterm.action.SpawnCommandInNewTab {
    args = { "codex" },
  },
})
-- Hacker-ish colors
config.colors = {
  foreground = "#9CFFB5",
  background = "#050A06",
  cursor_bg = "#00FF66",
  cursor_fg = "#001B0A",
  cursor_border = "#00FF66",

  selection_fg = "#001B0A",
  selection_bg = "#57FF9A",

  -- Make ANSI colors lean green-ish
  ansi = {
    "#06150B", "#FF3B30", "#00FF66", "#FFD60A",
    "#0A84FF", "#BF5AF2", "#64D2FF", "#C7FCD1",
  },
  brights = {
    "#0A2A14", "#FF453A", "#30FF86", "#FFE44D",
    "#5EAEFF", "#DA8FFF", "#9BE7FF", "#E7FFE9",
  },

  tab_bar = {
    background = "#050A06",
    active_tab = { bg_color = "#0A2A14", fg_color = "#9CFFB5", intensity = "Bold" },
    inactive_tab = { bg_color = "#050A06", fg_color = "#5CCF85" },
    new_tab = { bg_color = "#050A06", fg_color = "#00FF66" },
  },
}

-- Subtle “scanlines” using a gradient (no image needed)
config.window_background_gradient = {
  orientation = "Vertical",
  colors = { "#050A06", "#050A06", "#07160C", "#050A06" },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 8, -- tiny texture
}

-- Performance
config.front_end = "WebGpu"
config.scrollback_lines = 10000

-- Tabs (clean but still visible)
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Your keys (kept)
config.keys = {
  { key="t", mods="CTRL", action=wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key="h", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal({ domain="CurrentPaneDomain" }) },
  { key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical({ domain="CurrentPaneDomain" }) },
  { key="w", mods="CTRL", action=wezterm.action.CloseCurrentPane({ confirm=false }) },
  { key="w", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentTab({ confirm=false }) },
-- Replace these two:
-- {key="v", mods="CTRL", action=wezterm.action.PasteFrom("Clipboard")},
-- {key="c", mods="CTRL", action=wezterm.action.CopyTo("Clipboard")},

-- With these:
{key="c", mods="CTRL", action=wezterm.action.CopyTo("Clipboard")},
{key="v", mods="CTRL", action=wezterm.action.PasteFrom("Clipboard")},
}

return config