//
//  HeroSection.swift
//  Netflix
//
//  Created by Sameer Nikhil on 05/06/25.
//

import SwiftUI
import WebKit

// MARK: - FIXED YouTubeView for Device Compatibility

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        // Enhanced configuration for device playback
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .black
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Device-optimized HTML embed
        let embedHTML = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <style>
                * { margin: 0; padding: 0; box-sizing: border-box; }
                html, body { 
                    width: 100%; height: 100%; 
                    background-color: black; 
                    overflow: hidden; 
                }
                iframe { 
                    width: 100%; height: 100%; 
                    border: none; 
                    background-color: black; 
                }
            </style>
        </head>
        <body>
            <iframe
                src="https://www.youtube.com/embed/\(videoID)?autoplay=0&playsinline=1&controls=1&modestbranding=1&rel=0&showinfo=0&fs=1&enablejsapi=1"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """
        
        uiView.loadHTMLString(embedHTML, baseURL: URL(string: "https://netflix.com"))
        print("🎥 Loading YouTube video: \(videoID)")
    }
}

struct VideoScreen: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    YouTubeView(videoID: "kAtfaaUgDRU")
                        .frame(height: geometry.size.height / 2)

                    Color.black
                        .frame(height: geometry.size.height / 2)
                }
            }
        }
    }
}

#Preview {
    VideoScreen()
}
//kAtfaaUgDRU
