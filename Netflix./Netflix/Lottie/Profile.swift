//
//  Profile.swift
//  Netflix
//
//  Created by Sameer Nikhil on 08/06/25.
//

import Foundation

struct ProfileModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    
    var sourceAnchorID: String {
        return "PROFILE_\(id.uuidString)"
    }
}

// Mock profiles for the ProfileView
let mockProfiles: [ProfileModel] = [
    ProfileModel(name: "Sriram", icon: "Extraction"),
    ProfileModel(name: "Sameer", icon: "Joe"),
    ProfileModel(name: "Lakshman", icon: "kick"),
    ProfileModel(name: "Teddy", icon: "IceAge 1")
]
