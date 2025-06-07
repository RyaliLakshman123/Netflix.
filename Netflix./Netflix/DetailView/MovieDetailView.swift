//
//  MovieDetail.swift
//  Netflix
//
//  Created by Sameer Nikhil on 05/06/25.
//

import SwiftUI
import WebKit

struct MovieDetailView: View {
    let movie: Movie
    @State private var videoKey: String?
    @State private var isLoading = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let videoKey = videoKey {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        YouTubeView(videoID: videoKey)
                            .frame(height: UIScreen.main.bounds.height / 2)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(movie.overview)
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                    }
                }
            } else if isLoading {
                ProgressView("Loading Trailer...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text("Trailer not available")
                    .foregroundColor(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchTrailer()
        }
    }

    private func fetchTrailer() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=8d0e5bb27c4c28904e24b540f7415a84") else {
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { isLoading = false }
                return
            }

            do {
                let response = try JSONDecoder().decode(MovieVideosResponse.self, from: data)
                if let trailer = response.results.first(where: { $0.site == "YouTube" && $0.type == "Trailer" }) {
                    DispatchQueue.main.async {
                        self.videoKey = trailer.key
                        self.isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

#Preview {
    MovieDetailView(movie: Movie(
        id: 123,
        title: "Sample Movie",
        overview: "This is a sample movie used for previewing the MovieDetailView.",
        backdropPath: "/sample.jpg"
    ))
}
