//
//  VideoModels.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import Foundation

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    let official: Bool
    
    var youtubeURL: URL? {
        guard site == "YouTube" else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
/*import SwiftUI
 import Lottie

 struct SplashScreen: View {
     
     var body: some View {
         if let jsonURL {
             LottieView {
                  await LottieAnimation.loadedFrom(url: jsonURL)
              }
             .playing()
         }
     }
     
     private var jsonURL: URL? {
         if let bundlePath = Bundle.main.path(forResource: "Logo", ofType: "json") {
             return URL(filePath: bundlePath)
         }
         
         return nil
     }
 }

 #Preview {
     SplashScreen()
         .preferredColorScheme(.dark)
 }*/
