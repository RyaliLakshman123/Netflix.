//
//  MovieService.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//



import Foundation
import WebKit

class MovieService: ObservableObject {
    @Published var featuredMovie: Movie?
    @Published var videoKey: String?

    private let apiKey = "8d0e5bb27c4c28904e24b540f7415a84"
    private let movieID = 1060046

    func fetchFeaturedMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US") else {
            print("Invalid movie URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching movie: \(error)")
                return
            }

            guard let data = data else {
                print("No movie data received.")
                return
            }

            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self?.featuredMovie = movie
                    self?.fetchMovieVideo(movieID: movie.id)
                }
            } catch {
                print("Decoding movie failed: \(error)")
            }
        }.resume()
    }

    func fetchMovieVideo(movieID: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US") else {
            print("Invalid video URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching video: \(error)")
                return
            }

            guard let data = data else {
                print("No video data received.")
                return
            }

            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                if let trailer = response.results.first(where: { $0.site == "YouTube" && $0.type == "Trailer" }) {
                    DispatchQueue.main.async {
                        self?.videoKey = trailer.key
                        print("Trailer key: \(trailer.key)")
                    }
                } else {
                    print("No trailer found.")
                }
            } catch {
                print("Decoding video failed: \(error)")
            }
        }.resume()
    }
}
