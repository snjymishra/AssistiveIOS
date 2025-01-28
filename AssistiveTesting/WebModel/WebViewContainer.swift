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
            fatalError("Invalid URL string: \(urlString)")
        }
        self.url = url
        self.setupWebView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let request = URLRequest(url: self.url)
        webView.load(request)
    }

    deinit {
        webView = nil // Properly deallocate the WKWebView when the container is deallocated
    }
}

extension WebViewContainer: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView failed to load \(webView.url?.absoluteString ?? "unknown URL"): \(error.localizedDescription)")
    }
}
