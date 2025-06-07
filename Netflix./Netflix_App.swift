//
//  NetflixApp.swift
//  Netflix
//
//  Created by Sameer Nikhil on 07/06/25.
//

import SwiftUI

@main
struct NetflixApp: App {
    @State private var appData = AppData() // Create AppData instance
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(appData) // Provide it to the entire app
        }
        .windowResizability(.contentSize)
    }
}
