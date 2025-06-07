//
//  MyNetflixView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 05/06/25.
//

import SwiftUI

struct MyNetflixView: View {
    @Binding var currentProfile: ProfileData
    @State private var showProfileSheet = false
   
    // Your existing data arrays...
    let likedMovies = [
        MovieData(title: "Dragon", subtitle: "ANIME", imageURL: "https://image.tmdb.org/t/p/original/zpJWIDVffImwibMllLkOMwJ3wC4.jpg", color: .orange),
        MovieData(title: "Radhe Shyam", subtitle: "HINDI", imageURL: "https://image.tmdb.org/t/p/original/pN52D0wTP2PTIRUETz8pGRD7Cz6.jpg", color: .brown),
        MovieData(title: "Kalki 2898-AD", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/w440_and_h660_face/neoQU3SiKjE0Rzt7lOKChgyxOQe.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Worls War Z", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/aCnVdvExw6UWSeQfr0tUH3jr4qG.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Uncharted", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/aAh2jm5su3Fkk8qQXFc8TvyDpXb.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Enola Holmes", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/kmLsepbFIa80wPcKxGpy3CLaXSo.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Havoc", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/baVqYAsJYWwR5o5Y7tqxvYtvlKn.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Bullet Train", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/sklHxzGeSkfOddjhq07ftLqVd4k.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Virupaksha", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/fqMn4h9ctOyumII2nXDnm5mRTxQ.jpg", color: .yellow, isGolden: true),
        MovieData(title: "Leo", subtitle: "TELUGU", imageURL: "https://image.tmdb.org/t/p/original/vzzeYSh6QYyN9CcY0EmdZJvXH4l.jpg", color: .yellow, isGolden: true)
    ]
    
    let myListShows = [
        TVShowData(title: "Straw Hat Pirates", imageURL: "https://image.tmdb.org/t/p/original/k2jeRqMeTwI2UOfM3fAc6XEMxpZ.jpg", hasTopBadge: true),
        TVShowData(title: "Rana Naidu", imageURL: "https://image.tmdb.org/t/p/original/weVXMD5QBGeQil4HEATZqAkXeEc.jpg", hasTopBadge: true),
        TVShowData(title: "Stranger Things", imageURL: "https://image.tmdb.org/t/p/original/lz95rLPgvSV2o0EdnBUIqSRe5vc.jpg", hasTopBadge: false),
        TVShowData(title: "Dark Knight", imageURL: "https://image.tmdb.org/t/p/original/6xjWrC0l40t4vFi8gbF7snXwKeQ.jpg", hasTopBadge: false),
        TVShowData(title: "EndGame", imageURL: "https://image.tmdb.org/t/p/original/ge8hewUzdoAnxRWNzHQ8naQiBcG.jpg", hasTopBadge: false),
        TVShowData(title: "jhon wick", imageURL: "https://image.tmdb.org/t/p/original/ebusUSzWT1tHwaHIPLlRxIPG0OP.jpg", hasTopBadge: false),
        TVShowData(title: "Hobbs and Shaw", imageURL: "https://image.tmdb.org/t/p/original/ibWl0d856HPFoedh9bIwxwSAb3o.jpg", hasTopBadge: false),
        TVShowData(title: "Army of thieves", imageURL: "https://image.tmdb.org/t/p/original/ibHFGZxZc8GbgHzR0k9NL3Q09Wf.jpg", hasTopBadge: false),
        TVShowData(title: "SHANG-CHI", imageURL: "https://image.tmdb.org/t/p/original/j5ZeKzMxZus53z3aEtWcPdSltU7.jpg", hasTopBadge: false),
        TVShowData(title: "Free Guy", imageURL: "https://image.tmdb.org/t/p/original/yQBVfHArdXRsIN1o5iwvEHxzDcD.jpg", hasTopBadge: false)
    ]
    
    let watchedTrailers = [
        TrailerShowData(title: "Straw Hat Pirates", imageURL: "https://image.tmdb.org/t/p/w500/cMD9Ygz11zjJzAovURpO75Qg7rT.jpg", hasTopBadge: true),
        TrailerShowData(title: "Rana Naidu", imageURL: "https://image.tmdb.org/t/p/w500/lXS60geme1LlEob5Wgvj3KilClA.jpg", hasTopBadge: true),
        TrailerShowData(title: "Stranger Things", imageURL: "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg", hasTopBadge: false),
        TrailerShowData(title: "The Witcher", imageURL: "https://image.tmdb.org/t/p/w500/7vjaCdMw15FEbXyLQTVa04URsPm.jpg", hasTopBadge: false)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Fixed Top Navigation Bar
                HStack {
                    Text("My Netflix")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Navigation icons
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "airplayvideo")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .background(Color.black)
                
                // MARK: - Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // MARK: - Profile Section
                        VStack(spacing: 16) {
                            // Profile Image - Make this clickable with thin layer effect
                            Button(action: {
                                print(" Profile image tapped! Current: \(currentProfile.name)")
                                showProfileSheet = true
                            }) {
                                ZStack {
                                    // Main profile image
                                    Image(currentProfile.localImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    // Thin overlay layer that appears when sheet is shown
                                    if showProfileSheet {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.black.opacity(0.4))
                                            .frame(width: 100, height: 100)
                                            .transition(.opacity)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .animation(.easeInOut(duration: 0.2), value: showProfileSheet)
                            
                            // Profile Name - Make this button clickable
                            Button(action: {
                                print(" Profile name tapped! Current: \(currentProfile.name)")
                                showProfileSheet = true
                            }) {
                                HStack {
                                    Text(currentProfile.name)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .rotationEffect(.degrees(showProfileSheet ? 180 : 0))
                                        .animation(.easeInOut(duration: 0.2), value: showProfileSheet)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.top, 30)

                        // MARK: - Menu Options
                        VStack(spacing: 0) {
                            // Notifications
                            HStack {
                                HStack(spacing: 16) {
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Image(systemName: "bell.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18))
                                        )
                                    
                                    Text("Notifications")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                            
                            // Downloads
                            HStack {
                                HStack(spacing: 16) {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Image(systemName: "arrow.down")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18))
                                        )
                                    
                                    Text("Downloads")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                        }
                        .padding(.top, 40)
                        
                        // MARK: - Liked Content Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("TV Shows & Movies You have Liked")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(likedMovies, id: \.title) { movie in
                                        MovieCard(movieData: movie)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 30)
                        
                        // MARK: - My List Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("My List")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button("See All") {
                                    // Action
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(myListShows, id: \.title) { show in
                                        TVShowCard(showData: show)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 30)
                        
                        // MARK: - Watched Trailers Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Watched Trailers")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button("See All") {
                                    // Action
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(watchedTrailers, id: \.title) { trailer in
                                        TrailerShowCard(showData: trailer)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 100) // Space for tab bar
                    }
                }
            }
            
            // Thin background overlay when sheet is shown
            if showProfileSheet {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showProfileSheet = false
                    }
            }
        }
        .sheet(isPresented: $showProfileSheet) {
            ProfileSwitcherSheet(currentProfile: $currentProfile)
        }
        .onChange(of: currentProfile) { oldValue, newValue in
            print("Profile changed from \(oldValue.name) to \(newValue.name)")
        }
        .animation(.easeInOut(duration: 0.2), value: showProfileSheet)
    }
}

// MARK: - Profile Switcher Bottom Sheet
struct ProfileSwitcherSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var currentProfile: ProfileData
    
    let profiles = [
        ProfileData(name: "sameer", localImage: "Joe", hasLock: false),
        ProfileData(name: "Sriram", localImage: "Extraction", hasLock: false),
        ProfileData(name: "Lakshman", localImage: "kick", hasLock: false),
        ProfileData(name: "Teddy", localImage: "IceAge 1", hasLock: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Switch Profiles")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            
            // Current Profile Display (for debugging)
            Text("Current: \(currentProfile.name)")
                .foregroundColor(.yellow)
                .font(.caption)
                .padding(.top, 5)
            
            // Profiles Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 15) {
                ForEach(profiles, id: \.name) { profile in
                    Button(action: {
                        print("Button tapped for: \(profile.name)")
                        print("Current profile before: \(currentProfile.name)")
                        
                        // Force update with animation
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentProfile = profile
                        }
                        
                        print("Current profile after: \(currentProfile.name)")
                        
                        // Delay dismiss to see the change
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            dismiss()
                        }
                    }) {
                        VStack(spacing: 6) {
                            ZStack {
                                // Profile image
                                Image(profile.localImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                // Selection indicator
                                if currentProfile.name == profile.name {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 50, height: 50)
                                }
                                
                                // Lock overlay for restricted profiles
                                if profile.hasLock {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.black.opacity(0.7))
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Image(systemName: "lock.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                            
                            Text(profile.name)
                                .font(.caption2)
                                .foregroundColor(currentProfile.name == profile.name ? .white : .white)
                                .fontWeight(currentProfile.name == profile.name ? .bold : .regular)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // Add Profile Button
                Button(action: {
                    print("Add new profile tapped")
                }) {
                    VStack(spacing: 6) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.gray.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            )
                        
                        Text("Add Profile")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 25)
            .padding(.bottom, 15)
            
            // Manage Profiles Button
            Button(action: {
                print("Manage profiles tapped")
            }) {
                HStack {
                    Image(systemName: "pencil")
                        .font(.system(size: 20))
                    Text("Manage Profiles")
                        .font(.system(size: 20))
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
            }
            .padding(.bottom, 20)
        }
        .background(Color.gray.opacity(0.3))
        .presentationDetents([.height(220)])
        .presentationDragIndicator(.visible)
        .onAppear {
            print("Sheet appeared with current profile: \(currentProfile.name)")
        }
    }
}



// MARK: - Profile Data Model
struct ProfileData: Equatable {
    let name: String
    let localImage: String
    let hasLock: Bool
}

struct MovieData {
    let title: String
    let subtitle: String?
    let imageURL: String
    let color: Color
    let isGolden: Bool
    
    init(title: String, subtitle: String? = nil, imageURL: String, color: Color, isGolden: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.color = color
        self.isGolden = isGolden
    }
}

struct TVShowData {
    let title: String
    let imageURL: String
    let hasTopBadge: Bool
}

struct TrailerShowData {
    let title: String
    let imageURL: String
    let hasTopBadge: Bool
}

// MARK: - Movie Card Component
struct MovieCard: View {
    let movieData: MovieData
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: movieData.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(movieData.color.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        )
                }
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Button(action: {}) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 120, height: 40)
                        .cornerRadius(6)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "paperplane")
                            .font(.caption)
                        Text("Share")
                            .font(.caption)
                    }
                    .foregroundColor(.white)
                }
                .padding(.top, -15)
            }
            .padding(.top, 8)
        }
    }
}

// MARK: - TV Show Card Component
struct TVShowCard: View {
    let showData: TVShowData
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: showData.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        )
                }
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

// MARK: - Trailer Show Card Component
struct TrailerShowCard: View {
    let showData: TrailerShowData
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: showData.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        )
                }
                .frame(width: 120, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    MyNetflixView(currentProfile: .constant(ProfileData(name: "Sriram", localImage: "Extraction", hasLock: false)))
        .preferredColorScheme(.dark)
}
