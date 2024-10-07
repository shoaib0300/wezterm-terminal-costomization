# WezTerm Configuration

This is a custom configuration for [WezTerm](https://wezfurlong.org/wezterm/), a GPU-accelerated terminal emulator and multiplexer written in Rust. This configuration aims to provide a visually appealing and user-friendly terminal experience.

## Features

- **Font and Style**: Utilizes `JetBrains Mono` as the primary font with `Fira Code` as a fallback for icons and symbols.
- **Ligatures**: Enabled for a clean code representation.
- **Transparency**: Slight transparency applied to the window background for a modern aesthetic.
- **Color Scheme**: Uses the `Catppuccin Mocha` color scheme with custom foreground and background colors.
- **Custom Tab Bar Colors**: Personalized colors for active, inactive, and new tabs.
- **Background Image**: Option to add a background image (currently commented out).
- **Smooth Scrolling and GPU Rendering**: Enhanced performance through GPU acceleration and increased scrollback lines.
- **Cursor Customization**: Adjusts cursor blink rate and thickness.
- **Tab Bar Customization**: Positions the tab bar at the bottom and always shows it, even with one tab.
- **Keybindings**: Custom keybindings for easy navigation and pane management.

## Installation

1. **Install WezTerm**:
   Follow the installation instructions on the [WezTerm GitHub page](https://github.com/wez/wezterm#installing).

2. **Clone the Configuration**:
   Clone this repository or copy the configuration file to your WezTerm configuration directory:
   ```bash
   mkdir -p ~/.config/wezterm
   cp path/to/this/config.lua ~/.config/wezterm/
   ```

3. **Launch WezTerm**:
   Open WezTerm to see the new configuration in action.

## Configuration Details

### Font and Style

- **Primary Font**: JetBrains Mono
- **Fallback Font**: Fira Code
- **Font Size**: 12.0

### Color Scheme

- **Color Scheme**: Catppuccin Mocha
- **Main Text Color**: #cdd6f4
- **Background Color**: #1e1e2e

### Tab Bar Settings

- **Tab Bar Position**: Bottom
- **Always Show Tab Bar**
- **Custom Colors for Active and Inactive Tabs**

### Keybindings

- `CTRL + t`: Open a new tab
- `CTRL + SHIFT + h`: Split the current pane horizontally
- `CTRL + SHIFT + l`: Split the current pane vertically
- `CTRL + w`: Close the current pane
- `CTRL + SHIFT + w`: Close the current tab
- `CTRL + v`: Paste from clipboard
- `CTRL + c`: Copy to clipboard

## Customization

You can further customize this configuration to suit your preferences. Adjust font sizes, colors, keybindings, and other settings as desired.

## License

This configuration is free to use and modify. Contributions are welcome!

### Instructions

1. **Copy the Markdown text above** into a new file named `README.md` in your WezTerm configuration directory or wherever you want to keep this documentation.
2. **Modify any sections** if needed, such as adding specific details about how you use WezTerm or your preferred settings.

