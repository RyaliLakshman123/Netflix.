//
//  VideoPlayerView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI
import WebKit

// SwiftUI wrapper for WKWebView to load YouTube trailer
struct VideoPlayerView: UIViewRepresentable {
    let videoKey: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Create the full YouTube embed URL using the video key
        let embedURLString = "https://www.youtube.com/embed/\(videoKey)?playsinline=1"

        // Convert the string to a URL
        if let url = URL(string: embedURLString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoKey: "dQw4w9WgXcQ") // Example YouTube video
            .frame(height: 300)
            .previewLayout(.sizeThatFits)
    }
}
// avkit for video play back
