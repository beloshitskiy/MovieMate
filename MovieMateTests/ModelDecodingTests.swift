//
//  ModelDecodingTests.swift
//  MovieMateTests
//
//  Created by denis.beloshitsky on 16.02.2024.
//

import XCTest
@testable import MovieMate

final class ModelDecodingTests: XCTestCase {
    func testMovieDecoding() throws {
        let expected = Movie.mock

        let rawData = """
            {
                "filmId": "",
                "name": "Драйв",
                "description": "Великолепный водитель – при свете дня он выполняет каскадерские трюки на съёмочных площадках Голливуда, а по ночам ведет рискованную игру. Но один опасный контракт – и за его жизнь назначена награда. Теперь, чтобы остаться в живых и спасти свою очаровательную соседку, он должен делать то, что умеет лучше всего – виртуозно уходить от погони.",
                "imageUrl": "https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/921089d1-4ebd-4b6f-be74-bfe29b21fad1/orig",
                "releaseYear": "2011",
                "duration": "100",
                "genres": ["криминал", "драма"],
                "rating_imdb": "7.8",
                "rating_kp": "7.8"
            }
        """.data(using: .utf8)

        let data = try XCTUnwrap(rawData)

        let decoder = JSONDecoder()
        let movie = try decoder.decode(Movie.self, from: data)

        XCTAssertEqual(movie.id, expected.id)
        XCTAssertEqual(movie.name, expected.name)
        XCTAssertEqual(movie.description, expected.description)
        XCTAssertEqual(movie.posterURL, expected.posterURL)
        XCTAssertEqual(movie.releaseYear, expected.releaseYear)
        XCTAssertEqual(movie.duration, expected.duration)
        XCTAssertEqual(movie.genres, expected.genres)
        XCTAssertEqual(movie.rating, expected.rating)
        XCTAssertEqual(movie.kpRating, expected.kpRating)
    }

    func testGenreDecoding() throws {
        let expected = LobbyInfo.mock

        let rawData = """
        {
            "lobbyId": "123",
            "code": "123",
            "status": "FINISHED",
            "chosenGenres": ["Action", "Comedy"],
            "joinedPersons": ["Denis", "Vlad"],
            "isAvailableToStart": true,
            "matchedFilm": {
                "filmId": "",
                "name": "Драйв",
                "description": "Великолепный водитель – при свете дня он выполняет каскадерские трюки на съёмочных площадках Голливуда, а по ночам ведет рискованную игру. Но один опасный контракт – и за его жизнь назначена награда. Теперь, чтобы остаться в живых и спасти свою очаровательную соседку, он должен делать то, что умеет лучше всего – виртуозно уходить от погони.",
                "imageUrl": "https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/921089d1-4ebd-4b6f-be74-bfe29b21fad1/orig",
                "releaseYear": "2011",
                "duration": "100",
                "genres": ["криминал", "драма"],
                "rating_imdb": "7.8",
                "rating_kp": "7.8"
            }
        }
        """.data(using: .utf8)

        let data = try XCTUnwrap(rawData)

        let decoder = JSONDecoder()
        let lobbyInfo = try decoder.decode(LobbyInfo.self, from: data)

        XCTAssertEqual(lobbyInfo.lobbyId, expected.lobbyId)
        XCTAssertEqual(lobbyInfo.code, expected.code)
        XCTAssertEqual(lobbyInfo.appState, expected.appState)
        XCTAssertEqual(lobbyInfo.genresChosen, expected.genresChosen)
        XCTAssertEqual(lobbyInfo.usersJoined, expected.usersJoined)
        XCTAssertEqual(lobbyInfo.isAvailableToStart, expected.isAvailableToStart)
    }
}
