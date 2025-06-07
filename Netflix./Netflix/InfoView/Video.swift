//
//  Video.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI
import WebKit
import Foundation

// MARK: - TMDB Video Models

/// Response structure for TMDB video API calls
struct TMDBVideoResponse: Codable {
    let id: Int
    let results: [TMDBVideo]
}

/// Individual video item from TMDB API
struct TMDBVideo: Codable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    let official: Bool
    let size: Int
    
    /// Check if this is a YouTube trailer
    var isYouTubeTrailer: Bool {
        return site == "YouTube" && type == "Trailer"
    }
    
    /// Check if this is any YouTube video (fallback)
    var isYouTubeVideo: Bool {
        return site == "YouTube"
    }
}

// MARK: - TMDB Video Service

// MARK: - TMDB Video Service
@MainActor
class TMDBVideoService: ObservableObject {
    private let apiKey = "8d0e5bb27c4c28904e24b540f7415a84"
    private let baseURL = "https://api.themoviedb.org/3"
    
    @Published var isLoading = false
    
    func fetchMovieTrailer(movieId: Int, completion: @escaping (String?) -> Void) {
        isLoading = true
        let urlString = "\(baseURL)/movie/\(movieId)/videos?api_key=\(apiKey)"
        fetchVideoKey(from: urlString, completion: completion)
    }
    
    func fetchTVTrailer(tvId: Int, completion: @escaping (String?) -> Void) {
        isLoading = true
        let urlString = "\(baseURL)/tv/\(tvId)/videos?api_key=\(apiKey)"
        fetchVideoKey(from: urlString, completion: completion)
    }
    
    private func fetchVideoKey(from urlString: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.isLoading = false
                completion(nil)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(TMDBVideoResponse.self, from: data)
                        let trailer = response.results.first { video in
                            video.isYouTubeTrailer && video.official
                        } ?? response.results.first { video in
                            video.isYouTubeVideo
                        }
                        
                        completion(trailer?.key)
                    } catch {
                        print("Error decoding video response: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
// MARK: - Trailer Player View
// MARK: - Enhanced Trailer Player View

struct TrailerPlayerView: View {
    let videoKey: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if !videoKey.isEmpty {
                // Use the existing WebView from your Video.swift
                WebView(videoKey: videoKey)
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "play.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("Trailer not available")
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .cornerRadius(8)
                }
            }
            
            // Close button overlay
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(20)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            print("🎥 TrailerPlayerView appeared with videoKey: \(videoKey)")
        }
    }
}

// MARK: - Enhanced WebView for YouTube
struct WebView: UIViewRepresentable {
    let videoKey: String
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsPictureInPictureMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = UIColor.black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard !videoKey.isEmpty else { return }
        
        let embedHTML = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { 
                    margin: 0; 
                    padding: 0; 
                    background-color: black; 
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .video-container { 
                    position: relative; 
                    width: 100%; 
                    height: 56.25vw;
                    max-height: 100vh;
                }
                iframe { 
                    position: absolute; 
                    top: 0; 
                    left: 0; 
                    width: 100%; 
                    height: 100%; 
                    border: 0; 
                }
            </style>
        </head>
        <body>
            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/\(videoKey)?autoplay=1&playsinline=1&controls=1&rel=0&modestbranding=1&fs=1"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen>
                </iframe>
            </div>
        </body>
        </html>
        """
        
        webView.loadHTMLString(embedHTML, baseURL: nil)
        print("🎥 Loading YouTube video: \(videoKey)")
    }
}
// MARK: - Preview


#Preview {
    TrailerPlayerView(videoKey: "kAtfaaUgDRU")
}

#Preview("WebView Test") {
    WebView(videoKey: "dQw4w9WgXcQ")
}

// MARK: - How to use

/*
 
 ## Basic Usage (Hardcoded video):
 ```swift
 TrailerPlayerView(videoKey: "kAtfaaUgDRU")
#Preview {
    TrailerPlayerView(videoKey: "kAtfaaUgDRU")  // HIT 3 trailer - this will work!
}

// MARK: - How to use
/*
 In your HeroSection.swift, use:
 TrailerPlayerView(videoKey: "kAtfaaUgDRU")
 
 The video ID "kAtfaaUgDRU" comes from:
 https://www.youtube.com/watch?v=kAtfaaUgDRU
                              ^^^^^^^^^^^
                              This part is the video ID
 */*/
