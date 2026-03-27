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

    var url: URL?
    var debugMode: Bool = false
    var openExternalURLsInBrowser: Bool = false
    var windowWidth: CGFloat?
    var windowHeight: CGFloat?
    var windowX: CGFloat?
    var windowY: CGFloat?
    var borderless: Bool = false
    var alwaysOnTop: Bool = false

    private init() {

    }


}
