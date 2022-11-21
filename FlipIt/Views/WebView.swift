
//
//
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable{
    typealias UIViewType = WKWebView
    let url : URL?
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard  let url = url else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    
    
    
    
}




