//
//  AppState.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 09.12.2023.
//

import Foundation

enum AppState: String, Equatable {
    case notReadyToStart = "NOT_READY_TO_START"
    case readyToStart = "READY_TO_START"
    case choosingGenres = "GENRES_CHOOSING"
    case choosingGenresMatchError = "GENRES_MATCH_ERROR"
    case choosingGenresTimeout = "GENRES_TIMEOUT"
    case choosingMovies = "FILMS_CHOOSING"
    case choosingMoviesTimeout = "FILMS_TIMEOUT"
    case choosingMoviesMatchError = "FILMS_MATCH_ERROR"
    case finished = "FINISHED"

    func canChange(to: AppState) -> Bool {
        self == .notReadyToStart && to == .readyToStart
            || self == .readyToStart && to == .choosingGenres
            || self == .choosingGenres && to == .choosingGenresMatchError
            || self == .choosingGenres && to == .choosingGenresTimeout
            || self == .choosingGenres && to == .choosingMovies
            || self == .choosingMovies && to == .choosingMoviesTimeout
            || self == .choosingMovies && to == .choosingMoviesMatchError
            || self == .choosingMovies && to == .finished
    }
}

extension AppState: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawStr = try container.decode(String.self)
        self = AppState(rawValue: rawStr) ?? .notReadyToStart
    }
}
