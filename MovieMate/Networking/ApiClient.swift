//
//  ApiClient.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Alamofire
import Foundation

final class ApiClient {
    static let shared = ApiClient()

    private let mainURL = "/v1"

    // MARK: - Lobby

    func createLobby() async throws -> String {
        let response = await AF.request(mainURL + "lobbies", method: .post)
            .validate(statusCode: 200 ..< 300)
            .serializingString()
            .response

        switch response.result {
        case let .success(lobbyId):
            return lobbyId
        case .failure:
            throw ApiError.serverError
        }
    }

    func isStartAvailable() async throws -> Bool {
//        let response = await AF.request(mainURL + "lobbies", method: .post)
//            .validate(statusCode: 200 ..< 300)
//            .seri
//            .response
    }

    func joinLobby(lobbyId: String) async throws -> Bool {
        let response = await AF.request(mainURL + "lobbies/\(lobbyId)", method: .get)
            .validate(statusCode: 200 ..< 300)
            .serializingDecodable(Bool.self)
            .response

        switch response.result {
        case let .success(result):
            return result
        case .failure:
            throw ApiError.serverError
        }
    }

    // MARK: - Genres

    func getGenres() -> [Genre] {}

    func confirmChosen(genres: Set<Genre>) {}

    // MARK: - Deck

    func getMovie() async throws -> Movie {}

    func like(movie: Movie) async throws {}

    func dislike(movie: Movie) async throws {}

    // not sure about params
    func undo(movie: Movie) async throws {}
}
