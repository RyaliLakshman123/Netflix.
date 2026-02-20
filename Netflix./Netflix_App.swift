//
//<<<<<<< HEAD
//  NetflixApp.swift
//  Netflix
//=======
//  Netflix_App.swift
//  Netflix.
//>>>>>>> 891e55f0d27cc819431d713e499c8a1bbccc752c
//
//  Created by Sameer Nikhil on 07/06/25.
//

import SwiftUI

@main
//<<<<<<< HEAD
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
//=======
//struct Netflix_App: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
////>>>>>>> 891e55f0d27cc819431d713e499c8a1bbccc752c
//    }
//}
