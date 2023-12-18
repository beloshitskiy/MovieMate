//
//  WelcomePageViewModel.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

@MainActor
final class WelcomePageViewModel {
    weak var vc: UIViewController?

    func moveToCreateLobbyPage() {
        Router.shared.navigate(in: vc?.navigationController, to: .createLobbyPage)
    }

    func moveToJoinLobbyPage() {
        Router.shared.navigate(in: vc?.navigationController, to: .joinLobbyPage)
    }
}
