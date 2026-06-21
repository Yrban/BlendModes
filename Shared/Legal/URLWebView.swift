//
//  URLWebView.swift
//  HotHorse
//
//  Created by Developer on 7/16/20.
//  Copyright © 2020 Alelin Apps. All rights reserved.
//

import SwiftUI
import WebKit

struct UrlWebView: View {
    var urlToDisplay: URL

    var body: some View {
        WebViewRepresentable(url: urlToDisplay)
    }
}

#if os(iOS)
private struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
#else
private struct WebViewRepresentable: NSViewRepresentable {
    let url: URL
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    func updateNSView(_ nsView: WKWebView, context: Context) {}
}
#endif
