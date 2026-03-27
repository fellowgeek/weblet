//
//  ViewController.swift
//  enClose-MacOS
//
//  Created by Erfan Reed
//

// Import necessary libraries
import Cocoa
@preconcurrency import WebKit

// Define a ViewController class that inherits from NSViewController
class ViewController: NSViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!

    // Required initializer for decoding
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // Override the loadView() function to create and configure the WKWebView
    override func loadView() {
        super.loadView()

        let webConfiguration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.underPageBackgroundColor = .black
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
        if #available(macOS 13.3, iOS 16.4, tvOS 16.4, *) {
            if Config.shared.debugMode {
                webView.isInspectable = true
            }
        }
        view = webView
    }

    // Override the viewDidLoad() function to load the initial web page
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Config.shared.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // Function to disable user text selection via JavaScript
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        let javascriptStyle = """
            var css = '*{-webkit-touch-callout:none;-webkit-user-select:none}';
            var head = document.head || document.getElementsByTagName('head')[0];
            var style = document.createElement('style');
            style.type = 'text/css';
            style.appendChild(document.createTextNode(css));
            head.appendChild(style);
            """
        evaluateJavascript(javaScript: javascriptStyle)
    }

    // Handle opening of the external URLs
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        if Config.shared.openExternalURLsInBrowser && (url.scheme == "http" || url.scheme == "https") {
            decisionHandler(.cancel)
            NSWorkspace.shared.open(url)
        } else {
            decisionHandler(.allow)
        }
    }

    // This function evaluates javascript on the main webview
    func evaluateJavascript(javaScript: String) {
        if Config.shared.debugMode {
            Logger.info("Evaluating Javascript (main):\n>_ \(javaScript)")
        }
        webView.evaluateJavaScript(javaScript, completionHandler: nil)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}
