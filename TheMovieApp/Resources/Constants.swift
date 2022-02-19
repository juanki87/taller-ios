//
//  File.swift
//  TheMovieApp
//
//  Created by juanki on 2/9/22.
//

import Foundation

struct Constants {
    static let apiKey = "838160f885c68cbbe030ba7b5b15b8c8"
    struct URL  {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    struct Endpoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
