//
//  CustomTabBar.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Environment(AppData.self) private var appData
    @Binding var currentProfile: ProfileData
    
    let tabs = ["Home", "New & Hot", "My Netflix"]
    let icons = ["house", "play.square.stack", "Profile"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    appData.activeTab = index
                } label: {
                    VStack(spacing: 2) {
                        if icons[index] == "Profile" {
                            Image(currentProfile.localImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)
                                .clipShape(.rect(cornerRadius: 4))
                                .frame(width: 35, height: 35)
                        } else {
                            Image(systemName: icons[index])
                                .font(.title3)
                                .frame(width: 35, height: 35)
                        }
                        
                        Text(tabs[index])
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .opacity(appData.activeTab == index ? 1 : 0.6)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.95))
    }
}

#Preview {
    CustomTabBar(currentProfile: .constant(ProfileData(name: "Sriram", localImage: "Extraction", hasLock: false)))
        .environment(AppData())
        .preferredColorScheme(.dark)
}
