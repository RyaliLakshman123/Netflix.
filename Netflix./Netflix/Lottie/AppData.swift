//
//  AppData.swift
//  Netflix.
//
//  Created by Sameer Nikhil on 09/06/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class AppData {
    var activeTab: Int = 0
    var isSplashFinished: Bool = false
    var showProfileView: Bool = true // Start with profile view
    var animatedProfile: Bool = false
    var watchingProfile: ProfileModel? = nil // Changed to ProfileModel
    var tabProfileRect: CGRect = .zero
}
