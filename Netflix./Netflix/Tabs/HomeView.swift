//
//  HomeView.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI

// Content Item Model - moved to top level
struct ContentItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String? // Local images
    let imageURL: URL?  // TMDB image URL
}

// Action Movie Model
struct ActionMovie: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: URL
}

struct HomeView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.red.opacity(0.4),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Tab Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        TabChangeView(title: "TV Shows", isSelected: selectedTab == 0) {
                            selectedTab = 0
                        }
                        TabChangeView(title: "Movies", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }
                        TabChangeView(title: "Categories", isSelected: selectedTab == 2) {
                            selectedTab = 2
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                }
                
                // Main Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HeroSection()
                            .padding(.top, 0)
                        
                        LazyVStack(spacing: 20) {
                            // Always show Mobile Games
                            ContentRowView(
                                title: "Mobile Games",
                                items: getMobileGames()
                            )
                            
                            // Always show Top 10 TV Shows
                            ActionMovieRowView(
                                title: "Top 10 TV Shows",
                                movies: getTop10TVShows()
                            )
                            
                            // Always show Top 10 Movies
                            ActionMovieRowView(
                                title: "Top 10 Movies in India Today",
                                movies: getTop10Movies()
                            )
                            
                            // Always show Everyone's Watching
                            ActionMovieRowView(
                                title: "Everyone's Watching",
                                movies: getEveryoneWatchingMovies()
                            )
                            
                            // Always show Netflix Series
                            ActionMovieRowView(
                                title: "Netflix Series",
                                movies: getNetflixSeries()
                            )
                            
                            // Always show Netflix Originals
                            ActionMovieRowView(
                                title: "Netflix Originals",
                                movies: getNetflixOriginals()
                            )
                            
                            // Always show Action Movies
                            ActionMovieRowView(
                                title: "💥 Action Movies",
                                movies: getActionMovies()
                            )
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Navigation Bar Items
            ToolbarItem(placement: .navigationBarLeading) {
                Text("For Sriram")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    Button {
                        // TODO: Cast
                    } label: {
                        Image(systemName: "airplayvideo")
                    }
                    .foregroundColor(.white)
                    
                    Button {
                        // TODO: Download
                    } label: {
                        Image(systemName: "arrow.down.to.line.alt")
                    }
                    .foregroundColor(.white)
                    
                    Button {
                        // TODO: Search
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    // Mobile games (keep local images)
    private func getMobileGames() -> [ContentItem] {
        return [
            ContentItem(title: "World of Peppa Pig", subtitle: "Educational", imageName: "Peppa", imageURL: nil),
            ContentItem(title: "GTA: San Andreas", subtitle: "Action", imageName: "GTA 1", imageURL: nil),
            ContentItem(title: "SpongeBob: Get Cooking", subtitle: "Simulation", imageName: "spongebob", imageURL: nil),
            ContentItem(title: "Football Manager 2024", subtitle: "Sport", imageName: "football", imageURL: nil),
            ContentItem(title: "Black Mirror: Thronglets", subtitle: "Simulation", imageName: "mqdefault", imageURL: nil),
            ContentItem(title: "Into the Dead 2", subtitle: "Action", imageName: "dead", imageURL: nil),
            ContentItem(title: "TRANSFORMERS", subtitle: "Action", imageName: "transformers", imageURL: nil),
            ContentItem(title: "Narcos: Cartel Wars Unlimited", subtitle: "Strategy", imageName: "Narcos", imageURL: nil),
            ContentItem(title: "Money Heist", subtitle: "Interactive Story", imageName: "moneyheist", imageURL: nil),
            ContentItem(title: "Squid Game: Unleashed", subtitle: "Action", imageName: "squidgame", imageURL: nil)
        ]
    }
    
    // Top 10 TV Shows - Manual with TMDB images
    private func getTop10TVShows() -> [ActionMovie] {
        return [
            ActionMovie(title: "Wednesday", subtitle: "Horror Comedy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg")!),
            ActionMovie(title: "Stranger Things", subtitle: "Sci-Fi Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg")!),
            ActionMovie(title: "The Crown", subtitle: "Historical Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/1M876KQUEYGpLf7CUnBbcvyFd0t.jpg")!),
            ActionMovie(title: "Ozark", subtitle: "Crime Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/m73QMknkNLEGlBwRxOh3WKkJhd1.jpg")!),
            ActionMovie(title: "The Witcher", subtitle: "Fantasy Adventure", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/cZ0d3rtvXPVvuiX22sP79K3Hmjz.jpg")!),
            ActionMovie(title: "Money Heist", subtitle: "Crime Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg")!)
        ]
    }
    
    // Top 10 Movies - Manual with TMDB images
    private func getTop10Movies() -> [ActionMovie] {
        return [
            ActionMovie(title: "Red Notice", subtitle: "Action Comedy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/lAXONuqg41NwUMuzMiFvicDET9Y.jpg")!),
            ActionMovie(title: "The Gray Man", subtitle: "Action Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/5Eom3JsXgQlCj6QIsGCwXkX7wyH.jpg")!),
            ActionMovie(title: "Extraction", subtitle: "Action Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/wlfDxbGEsW58vGhFljKkcR5IxDj.jpg")!),
            ActionMovie(title: "Bird Box", subtitle: "Horror Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/rGfGfgL2pEPCfhIvqHXieXFn7gp.jpg")!),
            ActionMovie(title: "Enola Holmes", subtitle: "Mystery Adventure", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/riYInlsq2kf1AWoGm80JQW5dLKp.jpg")!),
            ActionMovie(title: "The Old Guard", subtitle: "Action Fantasy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/cjr4NWURcVN3gW5FlHeabgBHLrY.jpg")!)
        ]
    }
    
    // Everyone's Watching Movies
    private func getEveryoneWatchingMovies() -> [ActionMovie] {
        return [
            ActionMovie(title: "Glass Onion", subtitle: "Mystery Comedy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/vDGr1YdrlfbU9wxTOdpf3zChmv9.jpg")!),
            ActionMovie(title: "Don't Look Up", subtitle: "Dark Comedy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/th4E1yqsE8DGpAseLiUrI60Hf8V.jpg")!),
            ActionMovie(title: "The Adam Project", subtitle: "Sci-Fi Adventure", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/wFjboE0aFZNbVOF05fzrka9Fqyx.jpg")!),
            ActionMovie(title: "Spiderhead", subtitle: "Sci-Fi Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/7Sq9fwUI1hK1TxH8QmVmRE5DV4d.jpg")!),
            ActionMovie(title: "The Sea Beast", subtitle: "Animation Adventure", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9Cv7w8VxMJTjFJg5i6zGtPwG6aS.jpg")!),
            ActionMovie(title: "Hustle", subtitle: "Sports Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/2MIVdwH6PrGFOmGFAKGMDKP4OyM.jpg")!)
        ]
    }
    
    // Netflix Series
    private func getNetflixSeries() -> [ActionMovie] {
        return [
            ActionMovie(title: "House of Cards", subtitle: "Political Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/hKWxWjFwnMvkWQawbhvC0Y7ygQ8.jpg")!),
            ActionMovie(title: "Orange Is the New Black", subtitle: "Comedy Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/thAQOjIpYjIfqaJrt6bFg6PM6kF.jpg")!),
            ActionMovie(title: "Narcos", subtitle: "Crime Biography", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/rTmal9fDbwh5F0waol2hq35U4ah.jpg")!),
            ActionMovie(title: "The Queen's Gambit", subtitle: "Period Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/zU0htwkhNvBQdVSIKB9s6hgVeFK.jpg")!),
            ActionMovie(title: "Mindhunter", subtitle: "Crime Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/fbKE87mojpIkJPJJWSTB9rk8Kpx.jpg")!),
            ActionMovie(title: "Elite", subtitle: "Teen Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/3NTAbAiao4JLzFQw6YxP1YZppM8.jpg")!)
        ]
    }
    
    // Netflix Originals
    private func getNetflixOriginals() -> [ActionMovie] {
        return [
            ActionMovie(title: "Black Mirror", subtitle: "Sci-Fi Anthology", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/5UaYsGZOFhjFDwQh6GuLjjA5WSpO.jpg")!),
            ActionMovie(title: "Altered Carbon", subtitle: "Cyberpunk Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/tGJK6TUxHWM84M5IUBHoJWcCiSM.jpg")!),
            ActionMovie(title: "Russian Doll", subtitle: "Comedy Mystery", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/1z8FQVLkJUNNSJ6SQUnDpuI7N3R.jpg")!),
            ActionMovie(title: "GLOW", subtitle: "Comedy Drama", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/iQHmS0HqH8oqjrVgQhClOIzNSwv.jpg")!),
            ActionMovie(title: "BoJack Horseman", subtitle: "Animated Comedy", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/pB9L0jAnEQLMKgexqCEocEW8TA.jpg")!)
        ]
    }
    
    // Action Movies
    private func getActionMovies() -> [ActionMovie] {
        return [
            ActionMovie(title: "John Wick", subtitle: "Action Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg")!),
            ActionMovie(title: "The Matrix", subtitle: "Sci-Fi Action", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg")!),
            ActionMovie(title: "Mad Max: Fury Road", subtitle: "Post-Apocalyptic Action", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg")!),
            ActionMovie(title: "Die Hard", subtitle: "Action Thriller", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg")!),
            ActionMovie(title: "The Dark Knight", subtitle: "Superhero Action", imageURL: URL(string: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg")!)
        ]
    }
}

// Horizontal scrolling row for content
struct ContentRowView: View {
    let title: String
    let items: [ContentItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Section title
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("My List")
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            // Horizontal scrolling content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) { // Reduced spacing from 10 to 8
                    ForEach(items) { item in
                        ContentCardView(item: item)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// Individual content card - SMALLER SIZE FOR GAMES
// games section
struct ContentCardView: View {
     let item: ContentItem
     
     var body: some View {
         VStack(alignment: .leading, spacing: 4) { // Reduced spacing from 5 to 4
             // Content image - SMALLER SIZE FOR GAMES
             RoundedRectangle(cornerRadius: 8)
                 .fill(Color.gray.opacity(0.3))
                 .frame(width: 90, height: 120) // Reduced from 120x180 to 90x120
                 .overlay {
                     if let imageURL = item.imageURL {
                         // Load remote image
                         AsyncImage(url: imageURL) { image in
                             image
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: 90, height: 120)
                                 .clipped()
                                 .cornerRadius(8)
                         } placeholder: {
                             ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: .white))
                         }
                     } else if let imageName = item.imageName {
                         // Load local image from bundle
                         if let uiImage = UIImage(named: imageName) {
                             Image(uiImage: uiImage)
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: 90, height: 120)
                                 .clipped()
                                 .cornerRadius(8)
                         } else {
                             // Show fallback with image name for debugging
                             VStack {
                                 Text("❌")
                                     .font(.title2) // Smaller fallback icon
                                 Text(imageName)
                                     .font(.caption2)
                                     .foregroundColor(.red)
                             }
                             .frame(width: 90, height: 120)
                         }
                     } else {
                         // Fallback text
                         Text(item.title)
                             .font(.caption2) // Smaller fallback text
                             .foregroundColor(.white)
                             .multilineTextAlignment(.center)
                             .padding(4)
                     }
                 }
             
             // Title and subtitle - SMALLER TEXT
             VStack(alignment: .leading, spacing: 1) { // Reduced spacing
                 Text(item.title)
                     .padding(.horizontal, 2)
                     .font(.system(size: 13, weight: .medium)) // Reduced from 15 to 13
                     .foregroundColor(.white)
                     .lineLimit(2)
                 
                 Text(item.subtitle)
                     .padding(.horizontal, 2)
                     .font(.caption) // Smaller subtitle
                     .foregroundColor(.gray)
             }
             .frame(width: 90, alignment: .leading) // Match image width
         }
     }
}

// Action movie card row (remote images) - UNCHANGED SIZE
struct ActionMovieRowView: View {
    let title: String
    let movies: [ActionMovie]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading, spacing: 5) {
                            // KEEP ORIGINAL SIZE FOR MOVIES/SHOWS (120x180)
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 180) // Keep original size
                                .overlay {
                                    AsyncImage(url: movie.imageURL, scale: 1.0) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120, height: 180)
                                            .clipped()
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .frame(width: 120, height: 180)
                                    }
                                }
                            
                           // Text(movie.title)
                               // .font(.system(size: 15, weight: .medium))
                               // .foregroundColor(.white)
                                //.lineLimit(2)
                               // .padding(.horizontal, 4)
                            
                          //  Text(movie.subtitle)
                               // .font(.subheadline)
                               // .foregroundColor(.gray)
                               // .padding(.horizontal, 4)
                        }
                        .frame(width: 120, alignment: .leading)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView()
}

// Tab Button Component
struct TabChangeView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.gray : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}
