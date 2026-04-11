# weblet

A lightweight macOS web view application that can be launched and configured via command-line arguments.

![logo](docs/images/icon_256.png)

## Features

- Custom URL loading
- Adjustable window dimensions and positioning
- Borderless mode with draggable background
- "Always on top" window level
- Fullscreen mode
- Resizable window support
- Debug mode for web inspector access
- Optional external URL handling (open http/https in Safari)

## Installation

To install `weblet` using Homebrew, execute the following command:

```bash
brew install fellowgeek/tap/weblet
```

## Usage

To run `weblet`, execute the binary from the command line with optional flags.

### Configuration Flags

| Flag | Default | Description |
| :--- | :--- | :--- |
| `--url <value>` | `https://example.com` | The initial URL to load in the web view. |
| `--debug-mode <value>` | `off` | Enable the web inspector (`on` or `off`). |
| `--open-external-urls-in-browser` | `off` | When present, http/https links will open in the default browser. |
| `--window-width <value>` | 80% of screen | Window width in pixels. |
| `--window-height <value>` | 80% of screen | Window height in pixels. |
| `--window-x <value>` | Centered | Window origin X (top-left coordinate system). |
| `--window-y <value>` | Centered | Window origin Y (top-left coordinate system). |
| `--borderless` | `off` | Remove title bar and window chrome (draggable). |
| `--always-on-top` | `off` | Keep the window floating above all other windows. |
| `--fullscreen` | `off` | Launch the application in fullscreen mode. |
| `--resizable` | `off` | Allow the window to be resized by the user. |

## Example Usage

### 1. Launch with a specific URL at 1200x800, centered
```bash
./weblet --url https://github.com --window-width 1200 --window-height 800
```

### 2. Launch in Borderless Mode at a specific position
```bash
./weblet --url https://news.ycombinator.com --borderless --window-x 100 --window-y 100 --window-width 400 --window-height 600
```

### 3. Launch "Always on Top" with Debug Mode enabled
```bash
./weblet --url http://localhost:3000 --always-on-top --debug-mode on
```

### 4. Launch and open all external links in Safari
```bash
./weblet --url https://wikipedia.org --open-external-urls-in-browser
```

### 5. Launch in Fullscreen mode
```bash
./weblet --url https://vimeo.com --fullscreen
```

### 6. Launch with a resizable window
```bash
./weblet --url https://github.com --resizable
```

### 7. Launch with default settings (80% screen, centered, https://example.com)
```bash
./weblet
```
