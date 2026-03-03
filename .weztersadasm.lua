local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Fira Code",
})
config.font_size = 13.0

config.harfbuzz_features = {"calt=1", "clig=1", "liga=1"}

config.window_background_opacity = 0.85

config.color_scheme = 'Catppuccin Mocha'

config.colors = {
  foreground = "#ffffff",
  background = "#1e1e2e",
  tab_bar = {
    background = "#1e1e2e",
    active_tab = {
      bg_color = "#3b3052",
      fg_color = "#ffffff",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#ffffff",
    },
    new_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#ffffff",
    },
  },
}

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- Add Background Image add your path here and uncomment below line
-- config.window_background_image = '/home/shoaib/wget-images/pngtree-render-of-a-futuristic-holographic-cyborg-with-abstract-furistic-technology-solana-image_13555710.png'

-- Image appearance customization
config.window_background_image_hsb = {
  brightness = 0.3,  -- Darken the background image
  hue = 1.0,
  saturation = 1.0,
}


config.front_end = "WebGpu"
config.scrollback_lines = 10000

config.cursor_blink_rate = 500
config.cursor_thickness = 2

config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

config.window_decorations = "RESIZE"

config.inactive_pane_hsb = {
  brightness = 0.3,
}

config.keys = {
  {key="t", mods="CTRL", action=wezterm.action.SpawnTab("CurrentPaneDomain")},
  {key="h", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal({domain="CurrentPaneDomain"})},
  {key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical({domain="CurrentPaneDomain"})},
  {key="w", mods="CTRL", action=wezterm.action.CloseCurrentPane({confirm=false})},
  {key="w", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentTab({confirm=false})},
  {key="v", mods="CTRL", action=wezterm.action.PasteFrom("Clipboard")},
  {key="c", mods="CTRL", action=wezterm.action.CopyTo("Clipboard")},
}

return config
