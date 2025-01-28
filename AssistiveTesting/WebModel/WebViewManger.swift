//
//  WebViewManger.swift
//  AssistiveTesting
//
//  Created by Sanjay on 28/01/25.
//

import UIKit

public class WebViewManger {
    
    public static func presentWebView(on parentView: UIView, urlString: String) {
        let webView = WebViewContainer(frame: parentView.bounds, urlString: urlString)
        parentView.addSubview(webView)
    }
    
}
