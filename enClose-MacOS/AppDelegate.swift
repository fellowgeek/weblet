//
//  AppDelegate.swift
//  enClose-MacOS
//
//  Created by Erfan Reed
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
        let config = Config.shared
        
        guard let window = NSApplication.shared.windows.first else { return }
        
        let screen = window.screen ?? NSScreen.main ?? NSScreen.screens[0]
        let screenRect = screen.visibleFrame
        
        let width = config.windowWidth ?? (screenRect.width * 0.8)
        let height = config.windowHeight ?? (screenRect.height * 0.8)
        
        let x = config.windowX ?? (screenRect.origin.x + (screenRect.width - width) / 2)
        
        let y: CGFloat
        if let vy = config.windowY {
            // Convert top-left coordinate to bottom-left
            y = screenRect.maxY - height - vy
        } else {
            // Centered Y
            y = screenRect.origin.y + (screenRect.height - height) / 2
        }
        
        if config.borderless {
            window.styleMask.remove(.titled)
            window.styleMask.insert(.fullSizeContentView)
            window.titlebarAppearsTransparent = true
            window.titleVisibility = .hidden
            window.isMovableByWindowBackground = true
        }

        let frame = NSRect(x: x, y: y, width: width, height: height)
        window.setFrame(frame, display: true)
        
        if config.alwaysOnTop {
            window.level = .floating
        }
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}
