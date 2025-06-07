//
//  SplashScreen.swift
//  Netflix
//
//  Created by Sameer Nikhil on 06/06/25.
//

import SwiftUI
import Lottie
    
struct SplashScreen: View {
    @Environment(AppData.self) private var appData // Fixed: Use @Environment instead of @EnvironmentObject
    @State private var progress: CGFloat = 0.0
    
    var body: some View { 
        if let jsonURL {
            LottieView {
                await LottieAnimation.loadedFrom(url: jsonURL)
            }
            .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
            .animationDidFinish({ completed in
                appData.isSplashFinished = progress != 0 && completed
                appData.showProfileView = appData.isSplashFinished
            })
            .frame(width: 600, height: 600)
            .task {
                try? await Task.sleep(for: .seconds(0.15))
                progress = 0.8
            }
        }
    }
    
    private var jsonURL: URL? {
        if let bundlePath = Bundle.main.path(forResource: "logo", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        
        return nil
    }
}

#Preview {
    SplashScreen()
        .environment(AppData()) // Use .environment() for preview
        .preferredColorScheme(.dark)
}
