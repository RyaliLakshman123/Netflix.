//
//  ContentView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var appData = AppData()
    
    var body: some View {
        Group {
            if !appData.isSplashFinished {
                SplashScreen()
            } else if appData.showProfileView {
                ProfileView()
            } else {
                MainTabView()
            }
        }
        .environment(appData)
    }
}

#Preview {
    ContentView()
}
