//
//  MovieDetail.swift
//  TheMovieApp
//
//  Created by juanki on 2/18/22.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let originaltitle: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case originaltitle = "original_title"
        case voteAverage = "vote_average"
    }
}
