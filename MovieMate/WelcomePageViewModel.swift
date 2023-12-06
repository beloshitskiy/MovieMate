//
//  WelcomePageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

final class WelcomePageViewModel: ObservableObject {
    weak var vc: UIViewController?

    private let router = Router.shared

    func moveToCreateLobbyPage() {
        guard let nvc = vc?.navigationController else { return }
        let lobbyVM = LobbyPageViewModel(action: .create)
        router.navigate(in: nvc, to: .createLobbyPage(lobbyVM))
    }

    func moveToJoinLobbyPage() {
        guard let nvc = vc?.navigationController else { return }
        let lobbyVM = LobbyPageViewModel(action: .join)
        router.navigate(in: nvc, to: .joinLobbyPage(lobbyVM))
    }
}
