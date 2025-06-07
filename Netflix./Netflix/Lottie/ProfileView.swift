//
//  ProfileView.swift
//  Netflix.
//
//  Created by Sameer Nikhil on 08/06/25.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AppData.self) private var appData
    // view properties
    @State private var animateToCenter: Bool = false
    @State private var animateToDestination: Bool = false
    @State private var pathProgress: CGFloat = 0.0
    @State private var showBlackBackground: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button("Edit") {
                    print("Edit button tapped")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .overlay {
                    Text("Who's Watching?")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
               
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(110), spacing: 25), count: 2), spacing: 20) {
                    ForEach(Array(mockProfiles.enumerated()), id: \.element.id) { index, profile in
                        profileCardView(profile, index: index)
                    }
                    // add button
                    VStack {
                        Button(action: {
                            print("Add Profile button tapped")
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.8), lineWidth: 0.8)
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "plus")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .padding(.top, -90)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("Add Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                    }
                    .padding(.top, mockProfiles.count > 2 ? 30 : 0)
                    .padding(.top, -40)
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, -90)
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(showBlackBackground ? 0 : 1)
            .background(.black)
            
            // Black background overlay
            if showBlackBackground {
                Color.black
                    .ignoresSafeArea()
                    .opacity(animateToCenter ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: showBlackBackground)
            }
        }
        .overlayPreferenceValue(RectAnchorKey.self) { value in
            AnimationLayerView(value)
        }
    }
    
    // profile animation view
    @ViewBuilder
    func AnimationLayerView(_ value: [String: Anchor<CGRect>]) -> some View {
        GeometryReader { proxy in
            if let selectedProfile = appData.watchingProfile,
               let sourceAnchor = value[selectedProfile.sourceAnchorID],
               appData.animatedProfile {
                
                let sRect = proxy[sourceAnchor]
                let screenRect = proxy.frame(in: .global)
                
                // Define positions
                let sourcePosition = CGPoint(x: sRect.midX, y: sRect.midY)
                let centerPosition = CGPoint(x: screenRect.width / 2, y: (screenRect.height / 2) - 40)
                
                // Current position based on animation state
                let currentPosition: CGPoint = {
                    if !animateToCenter {
                        return sourcePosition
                    } else {
                        return centerPosition
                    }
                }()
                
                ZStack {
                    // Profile image
                    Image(selectedProfile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .background(.black)
                        .frame(
                            width: animateToCenter ? 180 : 100,
                            height: animateToCenter ? 180 : 100
                        )
                        .clipShape(.rect(cornerRadius: 10))
                        .position(currentPosition)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // Netflix loader - show when centered
                    if animateToCenter {
                        VStack(spacing: 12) {
                            NetflixLoader()
                                .frame(width: 100, height: 100)
                            
                        }
                        .position(x: centerPosition.x, y: centerPosition.y + 180)
                        .opacity(animateToCenter ? 1 : 0)
                        .animation(.easeIn(duration: 0.3).delay(0.2), value: animateToCenter)
                    }
                }
                .task {
                    guard !animateToCenter else { return }
                    await animateUser()
                }
            }
        }
    }
    
    func animateUser() async {
        // Phase 1: Move to center and show loader
        await withAnimation(.spring(duration: 0.6, bounce: 0.2)) {
            animateToCenter = true
        }
        
        // Phase 2: Loading simulation
        try? await Task.sleep(for: .seconds(2.0))
        
        // Phase 3: Complete animation and navigate
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.3)) {
                appData.animatedProfile = false
                appData.showProfileView = false
                showBlackBackground = false
            }
        }
    }
    
    // Profile View
    @ViewBuilder
    func profileCardView(_ profile: ProfileModel, index: Int) -> some View {
        VStack(spacing: 8) {
            let status = profile.id == appData.watchingProfile?.id
            Button(action: {
                print("Profile \(profile.name) selected")
            }) {
                GeometryReader { _ in
                    Image(profile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipShape(.rect(cornerRadius: 10))
                        .opacity(animateToCenter && status ? 0 : 1)
                        .padding(.top, -140)
                }
                .animation(status ? .none : .bouncy(duration: 0.35), value: animateToCenter)
                .frame(width: 100, height: 100)
                .anchorPreference(key: RectAnchorKey.self, value: .bounds, transform: { anchor in
                    return [profile.sourceAnchorID: anchor]
                })
                .onTapGesture {
                    // Reset all animation states
                    animateToCenter = false
                    animateToDestination = false
                    pathProgress = 0.0
                    
                    // Show black background immediately
                    showBlackBackground = true
                    
                    // Start the animation sequence
                    appData.watchingProfile = profile
                    withAnimation(.easeInOut(duration: 0.3)) {
                        appData.animatedProfile = true
                    }
                }
            }
            .buttonStyle(NoAnimationButtonStyle())
            
            Text(profile.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, -130)
        }
        .padding(.top, index >= 2 ? 30 : 0)
    }
}

#Preview {
    ProfileView()
        .environment(AppData())
        .preferredColorScheme(.dark)
}
