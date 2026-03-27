# weblet Project Context (GEMINI.md)

This document serves as the primary instructional context for the `weblet` project, a macOS hybrid application container.

## Project Overview

`weblet` (also referred to as `enClose-MacOS` in the codebase) is a **macOS application framework** built with Swift and WebKit. It is designed to host web-based content (HTML/CSS/JS) as a native application.

The core architecture follows a **Hybrid App** pattern:
- **UI:** Rendered in a `WKWebView` using standard web technologies.
- **Native Bridge:** Provides a custom communication layer between JavaScript and Swift using a message handler (`enClose`) and a custom `ios:` URI protocol.
- **Logging:** A centralized `Logger.swift` utility that wraps `os_log` for debugging and system diagnostics.

### Key Components
- **`AppDelegate.swift`**: Manages the application lifecycle.
- **`ViewController.swift`**: The heart of the application. It initializes the `WKWebView`, sets up the JavaScript bridge, and evaluates native calls.
- **`Logger.swift`**: Provides structured logging (Info, Debug, Error, Fault) to the system console.
- **`Main.storyboard`**: Defines the main application window and view controller setup.

---

## Building and Running

### Prerequisites
- macOS with Xcode installed.

### Development Commands
- **Run via Xcode**: Open `weblet.xcodeproj` and press `Cmd + R`.
- **Build via CLI**:
  ```bash
  xcodebuild -project weblet.xcodeproj -scheme weblet -configuration Debug
  ```
- **Tests**: (No automated tests detected in the current codebase. TODO: Implement XCTest cases for the native bridge).

### Web Content
The application expects its web assets (specifically `index.html`) to reside in a `www` directory within the application bundle. 
> **Note:** The `www` directory is currently not present in the root. Ensure it is added as a Folder Reference in Xcode before deployment.

---

## Development Conventions

### JavaScript-to-Native Bridge
To call native Swift methods from your web interface, send a message to the `enClose` handler using the following format:
```javascript
window.webkit.messageHandlers.enClose.postMessage("ios:MethodName?param1=value1&param2=value2");
```
Any Swift function exposed with `@objc` in `ViewController.swift` that matches `MethodName` can be invoked.

### Native-to-JavaScript Communication
Native Swift code can evaluate JavaScript in the `WKWebView` using the `evaluateJavascript(javaScript:)` helper method:
```swift
evaluateJavascript(javaScript: "console.log('Hello from Swift');")
```

### Debugging
- Enable **Web Inspector** by setting `ViewController.debugMode = true` in the source code.
- Logs are sent to the macOS Console (viewable via the `Console` app) under the category "App".

### Styling and Restrictions
The application injects CSS via JavaScript to disable user text selection and touch callouts by default (`-webkit-user-select:none`), making the web content feel more like a native UI.
