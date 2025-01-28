//
//  WebViewContainer.swift
//  AssistiveTesting
//
//  Created by Sanjay on 28/01/25.
//

import UIKit
import WebKit

public class WebViewContainer: UIView {
    private var webView: WKWebView!
    private var url: URL!
    
    public init(frame: CGRect, urlString: String) {
        super.init(frame: frame)
        guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            return
        }
        self.url = url
        self.setupWebView() // Only call this if the URL is valid
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implimented")
    }
    
    private func setupWebView() {
        guard webView == nil else { return } // Ensure it's only set up once
        
        // configure the web view
        webView = WKWebView(frame: self.bounds)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints for webview
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Load the URL
        if let url = self.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}

extension WebViewContainer: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView loading failed: \(error.localizedDescription)")
    }
}
