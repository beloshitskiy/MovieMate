//
//  WelcomePageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

final class WelcomePageViewModel {
    weak var vc: UIViewController?

    private let router = Router.shared

    func moveToCreateLobbyPage() {
        guard let vc else { return }
        let lobbyVM = LobbyPageViewModel(action: .create)
        router.navigate(from: vc, to: .createLobbyPage(lobbyVM))
    }

    func moveToJoinLobbyPage() {
        guard let vc else { return }
        let lobbyVM = LobbyPageViewModel(action: .join)
        router.navigate(from: vc, to: .joinLobbyPage(lobbyVM))
    }
}
