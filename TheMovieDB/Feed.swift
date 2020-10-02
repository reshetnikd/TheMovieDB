//
//  Feed.swift
//  TheMovieDB
//
//  Created by Dmitry Reshetnik on 02.10.2020.
//

import Foundation

struct Feed: Codable {
    var page: Int
    var results: [Movie]
    var totalResults: Int
    var totalPages: Int
}

struct Movie: Codable {
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAverage: Double
}
