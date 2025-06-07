//
//  Movie.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//


import Foundation

// Represents the movie object fetched from the TMDB API
struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?

    // Computed property to create full image URL
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

// Represents the video object for movie trailers
struct MovieVideo: Decodable {
    let key: String
    let site: String
    let type: String
}

struct MovieVideosResponse: Decodable {
    let results: [MovieVideo]
}

// https://api.themoviedb.org/3/movie/popular?api_key=8d0e5bb27c4c28904e24b540f7415a84
