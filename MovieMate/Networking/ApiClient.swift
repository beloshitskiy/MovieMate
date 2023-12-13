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
    private static let pollingManager = PollingManager()

    var currentState: AppState {
        lobbyInfo?.appState ?? .notReadyToStart
    }

    private let mainURL = "http://51.250.2.222:8081/v1"
    private let headers = HTTPHeaders([.init(name: "X-Device-Token", 
                                             value: UIDevice.current.identifierForVendor?.uuidString ?? "")])
    private var lobbyInfo: LobbyInfo?

    private var lobbyId: String { lobbyInfo?.code ?? "" }

    // MARK: - Polling manager

    func startPolling() {
        ApiClient.pollingManager.startPolling()
    }

    func stopPolling() {
        ApiClient.pollingManager.stopPolling()
    }

    func updateLobbyInfo() async {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)", method: .get, headers: headers)
            .validate()
            .serializingDecodable(LobbyInfo.self)
            .response

        print(response.debugDescription)

        switch response.result {
        case let .success(lobbyInfo):
            self.lobbyInfo = lobbyInfo
        case .failure:
            print("beda")
        }
    }

    // MARK: - Lobby

    func createLobby() async throws -> String {
        let response = await AF.request(mainURL + "/lobbies", method: .post, headers: headers)
            .validate()
            .serializingDecodable(LobbyInfo.self)
            .response

        print(response.debugDescription)

        switch response.result {
        case let .success(lobbyInfo):
            self.lobbyInfo = lobbyInfo
            return lobbyInfo.code
        case .failure:
            throw ApiError.serverError
        }
    }

    func joinLobby(lobbyId: String) async throws {
        let response = await AF.request(mainURL + "/lobbies/join/\(lobbyId)", method: .post, headers: headers)
            .validate()
            .serializingDecodable(LobbyInfo.self)
            .response

        print(response.debugDescription)

        switch response.result {
        case let .success(lobbyInfo):
            self.lobbyInfo = lobbyInfo
        case .failure:
            throw ApiError.serverError
        }
    }

    func deleteLobby() async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)", method: .delete, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }

    func startLobby() async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/start", method: .post, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }

    func restartLobby() async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/restart", method: .delete, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }

    // MARK: - Genres

    func getGenres() async throws -> [String] {
        let response = await AF.request(mainURL + "/genres", method: .get, headers: headers)
            .validate()
            .serializingDecodable([String].self)
            .response

        print(response.debugDescription)

        switch response.result {
        case let .success(result):
            return result
        case .failure:
            throw ApiError.serverError
        }
    }

    func confirmSelected(_ genres: [String]) async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/sessions", method: .post, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }

    // MARK: - Deck

    func getMovies() async throws -> [Movie] {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/films", method: .post, headers: headers)
            .validate()
            .serializingDecodable([Movie].self)
            .response

        switch response.result {
        case let .success(result):
            return result
        case .failure:
            throw ApiError.serverError
        }
    }

    func like(movie: Movie) async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/films/\(movie.id)", method: .post, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }

    func undoLike(movie: Movie) async throws -> Bool {
        let response = await AF.request(mainURL + "/lobbies/\(lobbyId)/films/\(movie.id)", method: .delete, headers: headers)
            .validate()
            .serializingDecodable(EmptyEntity.self, emptyResponseCodes: [200])
            .response

        print(response.debugDescription)

        switch response.result {
        case .success:
            return true
        case .failure:
            throw ApiError.serverError
        }
    }
}

private extension ApiClient {
    struct EmptyEntity: Decodable, EmptyResponse {
        static func emptyValue() -> EmptyEntity { .init() }
    }
}
