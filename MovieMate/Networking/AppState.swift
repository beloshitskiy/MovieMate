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
    case joinTimeout = "SESSION_TIMED_OUT"
    case choosingGenres = "GENRES_CHOOSING"
    case choosingGenresTimeout = "GENRES_TIMEOUT"
    case choosingMovies = "FILMS_CHOOSING"
    case choosingMoviesTimeout = "FILMS_TIMEOUT"
    case choosingMoviesMatchError = "FILMS_MATCH_ERROR"
    case finished = "FINISHED"
}

extension AppState: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawStr = try container.decode(String.self)
        self = AppState(rawValue: rawStr) ?? .notReadyToStart
    }
}
