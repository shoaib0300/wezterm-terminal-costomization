local wezterm = require "wezterm"
local config = wezterm.config_builder()
local home = wezterm.home_dir

local image_dir = home .. "/.config/wezterm/wget-images/"
local rotate_every_seconds = 60

local images = {
  "104787.jpg",
  "1920-connection-of-human-woman-and-artificial-intelligence-robot-the-concept-of-merging-a-person-and-a-computer-with-neural-networks-in-the-future-ai-generated.jpg",
  "1920-futuristic-beautiful-woman-robot-cyborg-with-metal-implants-on-blurred-background.jpg",
  "2151672000.jpg",
  "2400-futuristic-beautiful-woman-robot-cyborg-with-metal-implants-on-blurred-background.jpg",
  "getty-images-4mpfl1eAuME-unsplash.jpg",
  "getty-images-6xo2ihCFr9k-unsplash.jpg",
  "getty-images-aBBhXOTfzo0-unsplash.jpg",
  "getty-images-IKBYw2m2XRA-unsplash.jpg",
  "jack-dong-4olvb8py4L4-unsplash.jpg",
  "pngtree-render-of-a-futuristic-holographic-cyborg-with-abstract-furistic-technology-solana-image_13555710.png",
  "rapha-wilde-X0rEU9juF0I-unsplash.jpg",
  "SL_102419_24410_32.jpg",
}

local function image_path(index)
  return image_dir .. images[index]
end

math.randomseed(os.time())
wezterm.GLOBAL.wallpaper_index = wezterm.GLOBAL.wallpaper_index or math.random(#images)

local function next_index(current)
  if #images <= 1 then return 1 end
  local idx = current
  while idx == current do
    idx = math.random(#images)
  end
  return idx
end

local function apply_background(index)
  local gui = wezterm.gui
  if not gui then return end

  local img = image_path(index)
  wezterm.log_info("Switching wallpaper to: " .. img)

  for _, window in ipairs(gui.gui_windows()) do
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_image = img
    window:set_config_overrides(overrides)
  end
end

-- Recursive timer: fires every `rotate_every_seconds` regardless of focus
local function schedule_rotation()
  wezterm.time.call_after(rotate_every_seconds, function()
    wezterm.GLOBAL.wallpaper_index = next_index(wezterm.GLOBAL.wallpaper_index)
    apply_background(wezterm.GLOBAL.wallpaper_index)
    schedule_rotation() -- reschedule
  end)
end

wezterm.on("gui-startup", function()
  apply_background(wezterm.GLOBAL.wallpaper_index)
  schedule_rotation()
end)

-- Shell
config.default_prog = { "/usr/bin/zsh", "-l" }

-- Fonts
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Fira Code",
})
config.font_size = 13.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Window
config.window_decorations = "TITLE | RESIZE"
config.enable_scroll_bar = false
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

config.window_background_opacity = 1.0
config.window_background_image = image_path(wezterm.GLOBAL.wallpaper_index)
config.status_update_interval = 1000

config.window_background_image_hsb = {
  brightness = 0.2,
  hue = 1.0,
  saturation = 1.0,
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 450

-- Colors
config.colors = {
  foreground = "#9CFFB5",
  background = "#050A06",
  cursor_bg = "#00FF66",
  cursor_fg = "#001B0A",
  cursor_border = "#00FF66",
  selection_fg = "#001B0A",
  selection_bg = "#57FF9A",
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
    active_tab = {
      bg_color = "#0A2A14",
      fg_color = "#9CFFB5",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#050A06",
      fg_color = "#5CCF85",
    },
    new_tab = {
      bg_color = "#050A06",
      fg_color = "#00FF66",
    },
  },
}

-- Performance
config.front_end = "OpenGL"
config.scrollback_lines = 10000

-- Tabs
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Keys
config.keys = {
  { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  { key = "c", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
  {
    key = "A",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "codex" },
    }),
  },
}

return config