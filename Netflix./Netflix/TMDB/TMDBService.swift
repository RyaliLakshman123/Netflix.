//
//  TMDBService.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import Foundation

@MainActor
class TMDBService: ObservableObject {
    private let apiKey = "8d0e5bb27c4c28904e24b540f7415a84" 
    private let baseURL = "https://api.themoviedb.org/3"
    private let netflixProviderId = 8 // Netflix provider ID on TMDB
    
    @Published var netflixMovies: [ActionMovie] = []
    @Published var netflixSeries: [ActionMovie] = []
    @Published var netflixOriginals: [ActionMovie] = []
    @Published var isLoadingMovies = false
    @Published var isLoadingSeries = false
    @Published var isLoadingOriginals = false
    
    func fetchNetflixMovies() {
        isLoadingMovies = true
        // Get movies available on Netflix
        let urlString = "\(baseURL)/discover/movie?api_key=\(apiKey)&with_watch_providers=\(netflixProviderId)&watch_region=US&sort_by=popularity.desc"
        fetchContent(from: urlString, isMovie: true) { movies in
            DispatchQueue.main.async {
                self.netflixMovies = movies
                self.isLoadingMovies = false
            }
        }
    }
    
    func fetchNetflixSeries() {
        isLoadingSeries = true
        // Get TV shows available on Netflix
        let urlString = "\(baseURL)/discover/tv?api_key=\(apiKey)&with_watch_providers=\(netflixProviderId)&watch_region=US&sort_by=popularity.desc"
        fetchContent(from: urlString, isMovie: false) { series in
            DispatchQueue.main.async {
                self.netflixSeries = series
                self.isLoadingSeries = false
            }
        }
    }
    
    func fetchNetflixOriginals() {
        isLoadingOriginals = true
        // Get Netflix Original content
        let urlString = "\(baseURL)/discover/tv?api_key=\(apiKey)&with_networks=213&sort_by=popularity.desc"
        fetchContent(from: urlString, isMovie: false) { originals in
            DispatchQueue.main.async {
                self.netflixOriginals = originals
                self.isLoadingOriginals = false
            }
        }
    }
    
    private func fetchContent(from urlString: String, isMovie: Bool, completion: @escaping ([ActionMovie]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if isMovie {
                        let response = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
                        let content = response.results.compactMap { movie -> ActionMovie? in
                            guard let posterPath = movie.posterPath else { return nil }
                            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
                            return ActionMovie(
                                title: movie.title,
                                subtitle: self.getGenre(for: movie.genreIds),
                                imageURL: imageURL
                            )
                        }
                        completion(content)
                    } else {
                        let response = try JSONDecoder().decode(TMDBTVResponse.self, from: data)
                        let content = response.results.compactMap { show -> ActionMovie? in
                            guard let posterPath = show.posterPath else { return nil }
                            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
                            return ActionMovie(
                                title: show.name,
                                subtitle: self.getGenre(for: show.genreIds),
                                imageURL: imageURL
                            )
                        }
                        completion(content)
                    }
                } catch {
                    print("Error decoding content: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }
    
    private func getGenre(for genreIds: [Int]) -> String {
        let genres = [
            28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy",
            80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family",
            14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music",
            9648: "Mystery", 10749: "Romance", 878: "Sci-Fi", 10770: "TV Movie",
            53: "Thriller", 10752: "War", 37: "Western"
        ]
        
        if let firstGenreId = genreIds.first,
           let genre = genres[firstGenreId] {
            return genre
        }
        return "Netflix"
    }
}

// TMDB API Response Models for Movies
struct TMDBMovieResponse: Codable {
    let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}

// TMDB API Response Models for TV Shows
struct TMDBTVResponse: Codable {
    let results: [TMDBTVShow]
}

struct TMDBTVShow: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let overview: String
    let genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}
