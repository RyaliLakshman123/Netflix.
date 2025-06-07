//
//  HeroSection.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI

struct HeroSection: View {
    
    @StateObject private var movieService = MovieService()
    @State private var showPlayer = false
       
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let movie = movieService.featuredMovie {
                if let url = movie.backdropURL {
                    // Show the actual movie backdrop from API
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 550)
                            .clipped()
                    } placeholder: {
                        // Show HIT3 image while loading, or if API fails
                        Image("HIT3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 550)
                            .clipped()
                    }
                    .onAppear {
                        print("Loading backdrop from: \(url)")
                    }
                } else {
                    // Fallback to HIT3 image if no URL
                    Image("HIT3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 550)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack(spacing: 16) {
                        NavigationLink(destination: {
                            // Always play HIT 3 trailer regardless of API response
                            YouTubeView(videoID: "kAtfaaUgDRU")
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Play")
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 40)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(6)
                        }
                        
                        Button(action: {
                            // TODO: Add to My List action
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("My List")
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 40)
                            .background(Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        }
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 200)
                )
            } else {
                // Show HIT3 image while loading movie data
                Image("HIT3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 550)
                    .clipped()
            }
        }
        .cornerRadius(20)
        .frame(maxWidth: 90)
        .ignoresSafeArea(edges: .top)
        .onAppear {
            movieService.fetchFeaturedMovie()
        }
    }
}

#Preview {
    HeroSection()
}

// hit3 poster id 1060046

//  Text(movie.overview)
//.font(.subheadline)
//.foregroundColor(.white)
//.lineLimit(3)
