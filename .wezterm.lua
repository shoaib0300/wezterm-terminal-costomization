local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font and Style
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",      -- Primary font
  "Fira Code",           -- Fallback font for icons and symbols
})
config.font_size = 12.0  -- Adjust font size

-- Enable ligatures for clean code representation
config.harfbuzz_features = {"calt=1", "clig=1", "liga=1"}

-- Window background transparency
config.window_background_opacity = 0.8  -- Slight transparency for modern look

-- Color Scheme
config.color_scheme = 'Catppuccin Mocha'

-- Custom Color Scheme (Optional)
config.colors = {
  foreground = "#cdd6f4", -- Main text color
  background = "#1e1e2e", -- Dark background with blueish tint

  -- Tab Bar Colors
  tab_bar = {
    background = "#1e1e2e",  -- Overall background color of the tab bar
    active_tab = {
      bg_color = "#3b3052",
      fg_color = "#cdd6f4",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#cdd6f4",
    },
    new_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#cdd6f4",
    },
  },
}



-- Window Padding for better visual experience
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- Add Background Image
-- config.window_background_image = '/home/shoaib/wget-images/pngtree-render-of-a-futuristic-holographic-cyborg-with-abstract-furistic-technology-solana-image_13555710.png'

-- Image appearance customization
config.window_background_image_hsb = {
  brightness = 0.3,  -- Darken the background image
  hue = 1.0,
  saturation = 1.0,
}

-- Enable smooth scrolling and GPU rendering
config.front_end = "WebGpu"  -- Use GPU rendering for faster performance
config.scrollback_lines = 10000  -- Allow for more scrollback in the terminal

-- Cursor Settings
config.cursor_blink_rate = 500  -- Blink rate in milliseconds
config.cursor_thickness = 2      -- Set cursor thickness (use thickness instead of shape)

-- Tab Bar Customization
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false  -- Always show the tab bar
config.show_tabs_in_tab_bar = true           -- Show tabs in the tab bar
config.show_new_tab_button_in_tab_bar = true -- Show the default new tab button

-- Increase the thickness of the split lines
config.window_decorations = "RESIZE"

-- Configure inactive pane styling for separation
config.inactive_pane_hsb = {
  brightness = 0.3, -- Reduce brightness of inactive panes for better separation
}

-- Keybindings for easier navigation and pane management
config.keys = {
  {key="t", mods="CTRL", action=wezterm.action.SpawnTab("CurrentPaneDomain")}, -- New Tab
  {key="h", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal({domain="CurrentPaneDomain"})}, -- Split horizontally
  {key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical({domain="CurrentPaneDomain"})}, -- Split vertically
  {key="w", mods="CTRL", action=wezterm.action.CloseCurrentPane({confirm=false})}, -- Close current pane
  {key="w", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentTab({confirm=false})}, -- Close current tab
  {key="v", mods="CTRL", action=wezterm.action.PasteFrom("Clipboard")}, -- Paste
  {key="c", mods="CTRL", action=wezterm.action.CopyTo("Clipboard")},
}

-- and finally, return the configuration to wezterm
return config

