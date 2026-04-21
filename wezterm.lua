local wezterm = require "wezterm"
local config = wezterm.config_builder()
local home = wezterm.home_dir
local image_dir = home .. "/.config/wezterm/wget-images/"
local rotate_every_seconds = 1 * 60

local background_images = {
  "104787.jpg",
  "1920-connection-of-human-woman-and-artificial-intelligence-robot-the-concept-of-merging-a-person-and-a-computer-with-neural-networks-in-the-future-ai-generated.jpg",
  "1920-futuristic-beautiful-woman-robot-cyborg-with-metal-implants-on-blurred-background.jpg",
  "2151672000.jpg",
  "2400-futuristic-beautiful-woman-robot-cyborg-with-metal-implants-on-blurred-background.jpg",
  "5056413.jpg",
  "getty-images-4mpfl1eAuME-unsplash.jpg",
  "getty-images-6xo2ihCFr9k-unsplash.jpg",
  "getty-images-aBBhXOTfzo0-unsplash.jpg",
  "getty-images-IKBYw2m2XRA-unsplash.jpg",
  "jack-dong-4olvb8py4L4-unsplash.jpg",
  "nastia-petruk-rZX6KxPw5pg-unsplash.jpg",
  "pngtree-render-of-a-futuristic-holographic-cyborg-with-abstract-furistic-technology-solana-image_13555710.png",
  "rapha-wilde-X0rEU9juF0I-unsplash.jpg",
  "SL_102419_24410_32.jpg",
}

local function image_path(index)
  return image_dir .. background_images[index]
end

local function next_index(current)
  if #background_images <= 1 then
    return 1
  end
  local idx = current
  while idx == current do
    idx = math.random(#background_images)
  end
  return idx
end

math.randomseed(os.time())
local window_rotation_state = {}
local last_global_index = nil

local function set_window_image(window, index)
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_image = image_path(index)
  window:set_config_overrides(overrides)
end

local function pick_initial_index()
  if #background_images <= 1 then
    return 1
  end

  local idx = math.random(#background_images)
  while idx == last_global_index do
    idx = math.random(#background_images)
  end
  return idx
end

local function rotation_tick()
  local now = os.time()
  local gui = wezterm.gui
  if gui then
    for _, window in ipairs(gui.gui_windows()) do
      local id = window:window_id()
      local state = window_rotation_state[id]

      if not state then
        local idx = pick_initial_index()
        state = { index = idx, changed_at = now }
        window_rotation_state[id] = state
        last_global_index = idx
        set_window_image(window, idx)
      elseif now - state.changed_at >= rotate_every_seconds then
        state.index = next_index(state.index)
        state.changed_at = now
        last_global_index = state.index
        set_window_image(window, state.index)
      end
    end
  end

  wezterm.time.call_after(1.0, rotation_tick)
end

wezterm.on("gui-startup", function()
  rotation_tick()
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

-- ✅ BACKGROUND IMAGE (FIXED)
config.window_background_opacity = 1.0
config.window_background_image = image_path(1)

config.window_background_image_hsb = {
  brightness = 0.2,   -- controls darkness
  hue = 1.0,
  saturation = 1.0,
}

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 450

-- Colors (hacker style)
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
      intensity = "Bold"
    },
    inactive_tab = {
      bg_color = "#050A06",
      fg_color = "#5CCF85"
    },
    new_tab = {
      bg_color = "#050A06",
      fg_color = "#00FF66"
    },
  },
}

-- ❌ REMOVED: window_background_gradient (it was hiding your image)

-- Performance (more stable on Pop!_OS)
config.front_end = "OpenGL"
config.scrollback_lines = 10000

-- Tabs
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Keys (single definition only)
config.keys = {
  { key="t", mods="CTRL", action=wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key="h", mods="CTRL|SHIFT", action=wezterm.action.SplitHorizontal({ domain="CurrentPaneDomain" }) },
  { key="l", mods="CTRL|SHIFT", action=wezterm.action.SplitVertical({ domain="CurrentPaneDomain" }) },
  { key="w", mods="CTRL", action=wezterm.action.CloseCurrentPane({ confirm=false }) },
  { key="w", mods="CTRL|SHIFT", action=wezterm.action.CloseCurrentTab({ confirm=false }) },

  { key="c", mods="CTRL", action=wezterm.action.CopyTo("Clipboard") },
  { key="v", mods="CTRL", action=wezterm.action.PasteFrom("Clipboard") },

  { key="A", mods="CTRL|SHIFT", action=wezterm.action.SpawnCommandInNewTab {
      args = { "codex" },
    }
  },
}

return config