//
//  MainTabView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI
import UIKit

struct MainTabView: View {
    @State private var appData = AppData()
    @State private var currentProfile = ProfileData(name: "Sriram", localImage: "Extraction", hasLock: false)
    
    var body: some View {
        ZStack {
            if !appData.isSplashFinished {
                // Step 1: Show splash screen first
                SplashScreen()
                    .environment(appData)
            } else if appData.showProfileView {
                // Step 2: Show profile selection after splash
                ProfileView()
                    .environment(appData)
            } else {
                // Step 3: Show main app content after profile selection
                mainTabContent
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            print("🔍 MainTabView - isSplashFinished: \(appData.isSplashFinished)")
            print("🔍 MainTabView - showProfileView: \(appData.showProfileView)")
            print("🔍 MainTabView - watchingProfile: \(appData.watchingProfile?.name ?? "nil")")
        }
        .onChange(of: appData.watchingProfile) { _, newProfile in
            if let profile = newProfile {
                // Update current profile when animation completes
                currentProfile = ProfileData(
                    name: profile.name,
                    localImage: profile.icon,
                    hasLock: false
                )
            }
        }
    }
    
    @ViewBuilder
    private var mainTabContent: some View {
        ZStack {
            // Full screen content based on selected tab
            Group {
                if appData.activeTab == 0 {
                    NavigationView {
                        HomeView()
                    }
                } else if appData.activeTab == 1 {
                    NewHotView()
                } else if appData.activeTab == 2 {
                    NavigationView {
                        MyNetflixView(currentProfile: $currentProfile)
                            .navigationBarHidden(true)
                    }
                } else {
                    NavigationView {
                        HomeView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            
            // Tab Bar at the bottom
            VStack {
                Spacer()
                CustomTabBar(currentProfile: $currentProfile)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .environment(appData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
