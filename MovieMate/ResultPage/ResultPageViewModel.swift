//
//  ResultPageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 30.10.2023.
//

import Foundation
import UIKit

final class ResultPageViewModel {
    enum Result {
        case good
        case bad
    }

    weak var vc: UIViewController?

    let result: Result
    let matchedMovie: Movie?

    init(result: Result) {
        self.result = result
        matchedMovie = ApiClient.shared.lobbyInfo?.matchedMovie
    }

    func restartSession() {
        Task {
            try await ApiClient.shared.restartLobby()
            await Router.shared.navigate(in: vc?.navigationController, to: .genresChoosingPage, makeRoot: true)
        }
    }

    func leaveSession() {
        Task {
            ApiClient.shared.stopPolling()
            await Router.shared.navigate(in: vc?.navigationController, to: .welcomePage, makeRoot: true)
        }
    }
}
