//
//  Config.swift
//  weblet
//
//  Created by Erfan Reed
//

import Foundation
import AppKit

class Config {
    static let shared = Config()

    var url: URL? = URL(string: "https://example.com")
    var debugMode: Bool = false
    var openExternalURLsInBrowser: Bool = false
    var windowWidth: CGFloat?
    var windowHeight: CGFloat?
    var windowX: CGFloat?
    var windowY: CGFloat?
    var borderless: Bool = false
    var alwaysOnTop: Bool = false

    private init() {
        let arguments = CommandLine.arguments
        var i = 1
        while i < arguments.count {
            let arg = arguments[i]
            switch arg {
            case "--url":
                if i + 1 < arguments.count {
                    if let providedURL = URL(string: arguments[i + 1]) {
                        url = providedURL
                    }
                    i += 1
                }
            case "--debug-mode":
                if i + 1 < arguments.count {
                    debugMode = arguments[i + 1].lowercased() == "on"
                    i += 1
                } else {
                    debugMode = true
                }
            case "--open-external-urls-in-browser":
                openExternalURLsInBrowser = true
            case "--window-width":
                if i + 1 < arguments.count {
                    windowWidth = CGFloat(Double(arguments[i + 1]) ?? 0)
                    i += 1
                }
            case "--window-height":
                if i + 1 < arguments.count {
                    windowHeight = CGFloat(Double(arguments[i + 1]) ?? 0)
                    i += 1
                }
            case "--window-x":
                if i + 1 < arguments.count {
                    windowX = CGFloat(Double(arguments[i + 1]) ?? 0)
                    i += 1
                }
            case "--window-y":
                if i + 1 < arguments.count {
                    windowY = CGFloat(Double(arguments[i + 1]) ?? 0)
                    i += 1
                }
            case "--borderless":
                borderless = true
            case "--always-on-top":
                alwaysOnTop = true
            default:
                break
            }
            i += 1
        }
    }
}
