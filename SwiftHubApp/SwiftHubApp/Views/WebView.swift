//
//  WebView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 09/07/21.
//

import SwiftUI
import WebKit

struct BaseWebView: UIViewRepresentable {
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        let config = WKWebViewConfiguration()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs
        return WKWebView(frame: .zero, configuration: config)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else { return }
        
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct WebView: View {
    let url: URL?
    let title: String
    
    var body: some View {
        BaseWebView(url: url).navigationTitle(title)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "www.google.com"), title: "Google")
    }
}
