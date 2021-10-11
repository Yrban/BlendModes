//
//  URLWebView.swift
//  HotHorse
//
//  Created by Developer on 7/16/20.
//  Copyright © 2020 Alelin Apps. All rights reserved.
//

import SwiftUI
import WebKit

struct UrlWebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    var urlToDisplay: URL
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.load(URLRequest(url: urlToDisplay))
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
}
