local wezterm = require "wezterm"
local config = wezterm.config_builder()
local home = wezterm.home_dir

local image_dir = home .. "/.config/wezterm/wget-images/"
local rotate_every_seconds = 60

local background_images = {
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

math.randomseed(os.time())

local function image_path(i)
  return image_dir .. background_images[i]
end

local function next_index(current)
  local idx = current
  while idx == current do
    idx = math.random(#background_images)
  end
  return idx
end

wezterm.GLOBAL.wallpaper = wezterm.GLOBAL.wallpaper or {
  index = math.random(#background_images),
  last_update = os.time(),
}

local state = wezterm.GLOBAL.wallpaper

local function apply(window)
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_image = image_path(state.index)
  window:set_config_overrides(overrides)
end

local function rotate()
  if not wezterm.gui then return end

  local now = os.time()

  if now - state.last_update >= rotate_every_seconds then
    state.index = next_index(state.index)
    state.last_update = now

    for _, window in ipairs(wezterm.gui.gui_windows()) do
      apply(window)
    end
  end

  wezterm.time.call_after(1, rotate)
end

wezterm.on("gui-startup", function()
  wezterm.time.call_after(1, rotate)
end)

-- Shell
config.default_prog = { "/usr/bin/zsh", "-l" }

-- Fonts
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Fira Code",
})
config.font_size = 13.0

-- Window
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

config.window_background_opacity = 1.0
config.window_background_image = image_path(state.index)

config.window_background_image_hsb = {
  brightness = 0.2,
  hue = 1.0,
  saturation = 1.0,
}

return config